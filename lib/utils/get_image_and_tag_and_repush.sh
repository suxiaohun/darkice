repo="registry.sensetime.com"
namespace="wa_innovation"
version="v7.1.1"
prefix="pingcap"

declare -a arr1=(
  "pd"
  "tikv"
  "tidb"
)
declare -a arr2=(
  "tidb-pd"
  "tidb-tikv"
  "tidb-tidb"
)

for ((i = 0; i < ${#arr1[@]}; i++)); do
  old_image="${prefix}/${arr1[i]}:${version}"
  new_image="${repo}/${namespace}/${arr2[i]}:${version}-arm64"

  echo "---------------"
  echo $i
  echo $old_image
  echo $new_image
  echo "---------------"
  docker pull ${old_image}
  docker tag ${old_image} ${new_image}
  docker push ${new_image}
done
