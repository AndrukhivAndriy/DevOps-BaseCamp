/# gcloud config set project direct-builder-276316

/# gcloud config set compute/region europe-west3

/# gcloud config set compute/zone europe-west3-a

/# gcloud compute instances create webserver \
  --image-project=debian-cloud \
  --image-family=debian-10 \
  --tags="web", "http-server" \
  --metadata-from-file=startup-script="D:\terraform\apache2.sh"
  
/# gcloud sql instances create my-database-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=europe-west3 \
  --authorized-networks='0.0.0.0/0'\
  --storage-size=10GB \
  --storage-type=SSD \
