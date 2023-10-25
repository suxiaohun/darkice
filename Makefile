
REPO='10.4.243.51:5000'
PROJECT='darkice'
TAG='v0.0.1'

image:
	@docker build -t $(REPO)/$(PROJECT):$(TAG) .


push: image
	@docker push $(REPO)/$(PROJECT):$(TAG)


reset:
	@rails db:drop
	@rails db:create
	@rails db:migrate
	@rails db:seed