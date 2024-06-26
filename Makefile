
REPO='10.4.243.51:5000'
PROJECT='darkice'
TAG='v0.0.1'

image:
	@docker build -t $(REPO)/$(PROJECT):$(TAG) .


push: image
	@docker push $(REPO)/$(PROJECT):$(TAG)

image-prod:
	@rake assets:clobber
	@rake assets:precompile
	@docker build -t $(REPO)/$(PROJECT):$(TAG) .


push-ctr: image-prod
	@docker save -o $PROJECT.tar $(REPO)/$(PROJECT):$(TAG)
	@ctr -n k8s.io images import $PROJECT.tar
	@rm $PROJECT.tar

deploy:
	@cd /root/workspace/chronos/charts && helm install darkice darkice


reset:
	@rails db:drop
	@rails db:create
	@rails db:migrate
	@rails db:seed
	@rails s