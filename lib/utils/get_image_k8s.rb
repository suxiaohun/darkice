private_repo = "xxx"
private_namespace = "xxx/yyy"

#--------------k8s-----------------
k8s_repo = 'registry.k8s.io'
k8s_version = 'v1.27.4'
k8s_pause_version = '3.9'
k8s_etcd_version = '3.5.7-0'
k8s_coredns_version = 'v1.10.1'
k8s_images = []
k8s_images << [k8s_repo, "kube-apiserver:#{k8s_version}"]
k8s_images << [k8s_repo, "kube-controller-manager:#{k8s_version}"]
k8s_images << [k8s_repo, "kube-scheduler:#{k8s_version}"]
k8s_images << [k8s_repo, "kube-proxy:#{k8s_version}"]
k8s_images << [k8s_repo, "pause:#{k8s_pause_version}"]
k8s_images << [k8s_repo, "etcd:#{k8s_etcd_version}"]
k8s_images << [k8s_repo, "coredns/coredns:#{k8s_coredns_version}"]

#---------------cni---------------
cni_repo = "docker.io/calico"
cni_version = "v3.26.1"
cni_images = []
cni_images << [cni_repo, "apiserver:#{cni_version}"]
cni_images << [cni_repo, "kube-controllers:#{cni_version}"]
cni_images << [cni_repo, "pod2daemon-flexvol:#{cni_version}"]
cni_images << [cni_repo, "cni:#{cni_version}"]
cni_images << [cni_repo, "node:#{cni_version}"]
cni_images << [cni_repo, "typha:#{cni_version}"]
cni_images << [cni_repo, "csi:#{cni_version}"]
cni_images << [cni_repo, "node-driver-registrar:#{cni_version}"]
cni_images << ["quay.io/tigera", "operator:v1.30.4"]
#-------extra-------------
extra_images = []

def pull_images(images, ns, repo, namespace)
  images.each do |obj|
    old_image = "#{obj[0]}/#{obj[1]}"
    new_image = "#{repo}/#{namespace}/#{ns}/#{obj[1]}"
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

pull_images(k8s_images, 'k8s', private_repo, private_namespace)
pull_images(cni_images, 'cni', private_repo, private_namespace)
pull_images(extra_images, 'extra', private_repo, private_namespace)

# reverse_to_origin(k8s_images, k8s_repo, private_repo, private_namespace)



