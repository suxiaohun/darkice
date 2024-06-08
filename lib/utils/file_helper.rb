module FileHelper
  class << self
    def goto(file,lineno,page_size)
      lines = []
      ind = FileIndex.where(file_id: file.id, lineno: lineno).select(:position).first
      if ind
        File.open(file.path) do |io|
          io.pos = ind.position
          lines = io.first(page_size)
        end
      else
        build_index(file,lineno)
      end
      lines
    end

    def total_lines(file_path)
      output = `wc -l #{file_path}`
      output.split.first.to_i
    end

    def build_index(file,lineno)


    end
  end
end