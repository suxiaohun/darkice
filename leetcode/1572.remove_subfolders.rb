# frozen_string_literal: true
require 'pry'
# @param {String[]} folder
# @return {String[]}
def remove_subfolders(folder)
  folder2 = remove(folder)
  remove(folder2)
end

def remove(folder)
  _hash = {}
  folder.each_with_index do |f,i|
    arr = f.split("/")
    arr.shift
    check(arr, _hash,0,i)
  end
  arr = []
  _hash.each do |k,v|
    v.each do |kk,vv|
      arr << folder[vv[1]] if vv[0]==1
    end
  end
  #puts "---#{_hash}---#{arr}"
  arr
end


def check(arr, hs,level,index)
  k = arr[0]
  if arr.size == 1
    hs[level] ||= {}
    hs[level][k] ||= []
    hs[level][k] = [1,index]
    return
  end
  if hs[level] && hs[level][k] && hs[level][k][0] == 1
    nil
  elsif hs[level] && hs[level][k] && hs[level][k][0] == 0
    arr.shift
    level+=1
    check(arr, hs,level,index)
  else
    hs[level] ||= {}
    hs[level][k] = [0,index]
    arr.shift
    level+=1
    check(arr, hs,level,index)
  end
end


remove_subfolders(["/a","/a/b","/c/d","/c/d/e","/c/f"])
remove_subfolders(["/a","/a/b/c","/a/b/d"])
remove_subfolders(["/a/b/c","/a/b/ca","/a/b/d"])
remove_subfolders(["/ah/al/am","/ah/al"])