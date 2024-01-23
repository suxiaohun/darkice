module JobBase

  MODE_ONLINE = 0
  MODE_OFFLINE = 1

  def convert_time(s_time, e_time)
    s_time = Time.parse(s_time) + 8 * 60 * 60 if s_time
    e_time = Time.parse(e_time) + 8 * 60 * 60 if e_time

    return "" if e_time.nil? || s_time.nil?
    seconds = (e_time - s_time).to_i
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    remaining_seconds = seconds % 60

    time_str = ""
    time_str += "#{hours}h " if hours > 0
    time_str += "#{minutes}min " if minutes > 0
    time_str += "#{remaining_seconds}s"
    return "#{time_str}", s_time, e_time
  end

  def puts_table(arr,table_name="---")
    # binding.pry
    cols = arr[0].size
    col_length = []
    cols.times do |i|
      col_length << arr.map{|x|x[i].to_s.size}.max
    end

    title2 = "+"
    cols.times do |i|
      title2 += "#{'-'*(col_length[i]+2)}+"
    end
    puts title2

    puts "|#{table_name.center(title2.size-2)}|"
    puts title2

    arr.each do |row|
      row_prefix = "| "
      cols.times do |i|
        #       puts "| %-28s | %-15s |" % ["dbscan", "dbscan"]
        row_prefix += "%-#{col_length[i]}s | "
      end
      puts row_prefix % row
    end

    puts title2
  end
  def get_reason_count(events, reg_str)
    events_hash = events.dup
    count = 0
    timestamp = nil
    events_hash.each do
      temp_e = events.shift

      if temp_e["reason"].include? reg_str
        count = temp_e["reason"].scan(/\d+/).map(&:to_i)[0]
        timestamp = temp_e["timestamp"]
        break
      end
    end
    return count, timestamp
  end

  def get_job_events(job, mode)
    return job["events"] if mode == MODE_OFFLINE
    get_job(job["id"])["events"].reverse
  end

  def stage_gcn(events, stage = 0)
    unless events
      puts "no events!"
      return
    end

    _, start_time = get_reason_count(events, "[DistributedGCNFeaturePipeline] loop #{stage}")
    total_target, _ = get_reason_count(events, "total target: [Row(sum(size(target_ids))")
    feature_count, end_time = get_reason_count(events, "[DistributedGCNFeaturePipeline] feature count")
    cost = convert_time(start_time, end_time)

    table = []
    table << ["total_target",total_target]
    table << ["feature_count",feature_count]
    table << ["cost",cost[0]]

    puts_table table,"gcn#{stage}"
  end

  def stage_dbscan(events)
    unless events
      puts "no events!"
      return
    end

    _, start_time = get_reason_count(events, "[DBSCANClustering] start search")
    total_target, _ = get_reason_count(events, "total target: [Row(sum(size(target_ids))")
    new_clusters_count, _ = get_reason_count(events, "[profile] counter, new_clusters_count")
    _, end_time = get_reason_count(events, ", clustering done")
    cost = convert_time(start_time, end_time)

    table = []
    table << ["total_target",total_target]
    table << ["new_clusters_count",new_clusters_count]
    table << ["cost",cost[0]]

    puts_table table,"dbscan"
  end



  def stage_refine(events)
    unless events
      puts "no events!"
      return
    end


    _, start_time = get_reason_count(events, "refined_clusters_df_count")
    document_count, _ = get_reason_count(events, "document count")
    classified_clusters_count, _ = get_reason_count(events, "classified clusters count")
    document_after_absorb_count, _ = get_reason_count(events, "document after absorb count")
    clusters_count_before_refine, _ = get_reason_count(events, "clusters count before refine")
    refined_cluster_count, end_time = get_reason_count(events, "refined cluster count")
    cost = convert_time(start_time, end_time)

    table = []
    table << ["document_count",document_count]
    table << ["classified_clusters_count",classified_clusters_count]
    table << ["document_after_absorb_count",document_after_absorb_count]
    table << ["clusters_count_before_refine",clusters_count_before_refine]
    table << ["refined_cluster_count",refined_cluster_count]
    table << ["cost",cost[0]]

    puts_table table,"refine"
  end

  def stage_merge(events)
    unless events
      puts "no events!"
      return
    end

    _, start_time = get_reason_count(events, "[DistributedCSTKClusterMerge] refine unstable clusters using dbscan start")
    total_target1, _ = get_reason_count(events, "total target: [Row(sum(size(target_ids))")
    unstable_clusters_count_after_refine, _ = get_reason_count(events, "[DistributedCSTKClusterMerge] unstable clusters count after refine")
    total_target2, _ = get_reason_count(events, "total target: [Row(sum(size(target_ids))")
    merge_document_searched_targets_count, _ = get_reason_count(events, "[DistributedCSTKClusterMerge]merge document searched targets count")
    search_result_count, _ = get_reason_count(events, "[DistributedCSTKClusterMerge] search document done, search result count")
    new_max_cluster_id, _ = get_reason_count(events, "[DistributedCSTKClusterMerge] new max cluster id")
    _, end_time = get_reason_count(events, ", cluster merge")
    cost = convert_time(start_time, end_time)

    table = []
    table << ["total_target",total_target1]
    table << ["unstable_clusters_count_after_refine",unstable_clusters_count_after_refine]
    table << ["total_target",total_target2]
    table << ["merge_document_searched_targets_count",merge_document_searched_targets_count]
    table << ["search_result_count",search_result_count]
    table << ["new_max_cluster_id",new_max_cluster_id]
    table << ["cost",cost[0]]

    puts_table table,"merge"
  end

  def stage_io(events,loop=0)
    unless events
      puts "no events!"
      return
    end

    _, start_time = get_reason_count(events, "[profile] counter, operated_isolate_clusters_df")
    # total_target1, _ = get_reason_count(events, "total target: [Row(sum(size(target_ids))")

    _, end_time = get_reason_count(events, ", [loop #{loop}] end")

    cost = convert_time(start_time, end_time)

    table = []
    # table << ["total_target",total_target1]

    table << ["cost",cost[0]]

    puts_table table,"io"
  end

  def analyze1(jobs, max_count, job_id, mode)
    count = 0
    jobs.each do |job_info|
      job = job_info["job"] || job_info
      count += 1
      break if count > max_count

      cost, s_time, e_time = convert_time(job["created_at"], job["finished_at"])

      puts "#{job["id"].ljust(5)} #{job["name"].ljust(35)} #{job["result"]["status"].ljust(8)} #{s_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{e_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{cost}"
      unless job_id.nil?
        if job_id == job["id"]
          events = get_job_events(job_info, mode)
          puts "----------------------------------------"
          events.each do |event|
            puts "#{event["timestamp"]} => #{event["reason"]}"
          end
          puts "----------------------------------------"
        end
      end
    end
  end

  def analyze2(jobs, max_count, job_id, mode)
    count = 0
    jobs.each do |job_info|
      job = job_info["job"] || job_info
      count += 1
      break if count > max_count

      cost, s_time, e_time = convert_time(job["created_at"], job["finished_at"])

      puts "#{job["id"].ljust(5)} #{job["name"].ljust(35)} #{job["result"]["status"].ljust(8)} #{s_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{e_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{cost}"
      unless job_id.nil?
        if job_id == job["id"]
          events = get_job_events(job_info, mode)
          stage_gcn(events, 0)
          stage_gcn(events, 1)
          stage_dbscan(events)
          stage_refine(events)
          stage_merge(events)
          stage_io(events,0)
          #----loop 0 end-------
          puts "*"*100
          puts "*"*100
          stage_gcn(events, 0)
          stage_gcn(events, 1)
          stage_dbscan(events)
          stage_refine(events)
          stage_merge(events)
          stage_io(events,1)
        end
      end
    end
  end

end