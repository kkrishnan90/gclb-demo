#! /bin/bash
echo "Creating instance template..."
gcloud compute instance-templates create web-instance-template --machine-type=f1-micro --metadata-from-file=startup-script=./startup.sh
sleep 5
echo "Creating managed instance group in US region..."
gcloud compute instance-groups managed create us-mig --size=1 --template web-instance-template --region=us-central1
sleep 5
echo "Creating managed instance group in ASIA region..."
gcloud compute instance-groups managed create asia-mig --size=1 --template web-instance-template --region=asia-southeast1
sleep 5

echo "Adding named ports for the to the instance group..."
gcloud compute instance-groups set-named-ports us-mig --named-ports http:80 --region us-central1
sleep 5
gcloud compute instance-groups set-named-ports asia-mig --named-ports http:80 --region asia-southeast1
sleep 5

echo "Creating health checks for managed instance groups..."
gcloud compute health-checks create http http-basic-check --port 80
sleep 5

echo "Creating backend services for managed instance groups..."
gcloud compute backend-services create web-backend-service --load-balancing-scheme=EXTERNAL --protocol=HTTP --port-name=http --health-checks=http-basic-check --global
sleep 5
echo "Adding instance groups as backend to the backend service..."
echo "Adding US backend..."
gcloud compute backend-services add-backend web-backend-service --instance-group=us-mig --instance-group-region=us-central1 --global
sleep 5
echo "Adding ASIA backend..."
gcloud compute backend-services add-backend web-backend-service --instance-group=asia-mig --instance-group-region=asia-southeast1 --global
sleep 5
echo "Creating url maps for backend services..."
gcloud compute url-maps create web-map-http --default-service web-backend-service --description "Map for http backend service" --global
sleep 5

echo "Setting up http frontend..."
gcloud compute target-http-proxies create http-lb-proxy --url-map=web-map-http --global
sleep 5
echo "Creating forwarding rules for http frontend..."
gcloud compute forwarding-rules create http-content-rule --load-balancing-scheme=EXTERNAL --global --target-http-proxy=http-lb-proxy --ports=80
