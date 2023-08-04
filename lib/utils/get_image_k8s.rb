private_repo = "registry.sensetime.com"
private_namespace = "wa_innovation/huxiaoyang"

#--------------k8s-----------------
k8s_repo = 'registry.k8s.io'
k8s_version = 'v1.27.4'
k8s_pause_version = '3.9'
k8s_etcd_version = '3.5.7-0'
k8s_coredns_version = 'v1.10.1'
k8s_images = []
k8s_images << ['kube-apiserver', k8s_version]
k8s_images << ['kube-controller-manager', k8s_version]
k8s_images << ['kube-scheduler', k8s_version]
k8s_images << ['kube-proxy', k8s_version]
k8s_images << ['pause', k8s_pause_version]
k8s_images << ['etcd', k8s_etcd_version]
k8s_images << ['coredns/coredns', k8s_coredns_version]

#---------------cni---------------
cni_repo = "docker.io/calico"
cni_version = "v3.26.1"
cni_images = []
cni_images << ["apiserver", cni_version]
cni_images << ["kube-controllers", cni_version]
cni_images << ["pod2daemon-flexvol", cni_version]
cni_images << ["cni", cni_version]
cni_images << ["node", cni_version]
cni_images << ["typha", cni_version]
cni_images << ["csi", cni_version]
cni_images << ["node-driver-registrar", cni_version]

#-------extra-------------
extra_images=[]
extra_images << ["quay.io/tigera/operator:v1.30.4"]


def pull_k8s(k8s_images, k8s_repo, repo, namespace)
  k8s_images.each do |obj|
    old_image = "#{k8s_repo}/#{obj[0]}:#{obj[1]}"
    new_image = "#{repo}/#{namespace}/#{obj[0]}:#{obj[1]}"
    puts old_image
    puts new_image
    system "docker pull #{old_image}"
    system "docker tag #{old_image} #{new_image}"
    system "docker push #{new_image}"
  end
end

def pull_cni(cni_images, cni_repo, repo, namespace)
  cni_images.each do |obj|
    old_image = "#{cni_repo}/#{obj[0]}:#{obj[1]}"
    new_image = "#{repo}/#{namespace}/#{obj[0]}:#{obj[1]}"
    puts old_image
    puts new_image
    system "docker pull #{old_image}"
    system "docker tag #{old_image} #{new_image}"
    system "docker push #{new_image}"
  end
end

def pull_extra(images,repo,namespace)
  images.each do |obj|
    old_image = "#{cni_repo}/#{obj[0]}:#{obj[1]}"
    new_image = "#{repo}/#{namespace}/#{obj[0]}:#{obj[1]}"
    puts old_image
    puts new_image
    system "docker pull #{old_image}"
    system "docker tag #{old_image} #{new_image}"
    system "docker push #{new_image}"
  end
end

def reverse_to_origin(arr, k8s_repo, repo, namespace)
  arr.each do |obj|
    old_image = "#{k8s_repo}/#{obj[0]}:#{obj[1]}"
    new_image = "#{repo}/#{namespace}/#{obj[0]}:#{obj[1]}"
    puts old_image
    puts new_image
    system "docker pull #{new_image}"
    system "docker tag #{new_image} #{old_image}"
  end
end

pull_k8s(k8s_images,k8s_repo,private_repo,private_namespace)
pull_cni(cni_images,cni_repo,private_repo,private_namespace)


reverse_to_origin(k8s_images, k8s_repo, private_repo, private_namespace)



