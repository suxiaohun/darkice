
REPO='10.4.243.51:5000'
PROJECT='darkice'
TAG='v0.0.1'

image:
	@docker build -t $(REPO)/$(PROJECT):$(TAG) .


push: image
	@docker push $(REPO)/$(PROJECT):$(TAG)

push-ctr: image
	@docker save -o $PROJECT.tar $(REPO)/$(PROJECT):$(TAG)
	@ctr -n k8s.io images import $PROJECT.tar
	@rm $PROJECT.tar

reset:
	@rails db:drop
	@rails db:create
	@rails db:migrate
	@rails db:seed
	@rails s