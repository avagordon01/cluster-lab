# pricing

- github (including actions and gchr.io) is free for public repos/images
- pulumi has 500 deployment minutes free
  use pulumi self managed state in gcp to avoid paying 
  https://www.pulumi.com/docs/iac/concepts/state-and-backends/#google-cloud-storage
- gcp
  - buckets ~$1-10/month https://cloud.google.com/storage/pricing-examples
    free tier in us-east1
  - postgresql $10/month https://cloud.google.com/sql/docs/postgres/pricing-examples
  - machines $80 / 2 core VM / month, probably $800 / month for a decent size cluster https://cloud.google.com/compute/all-pricing
    free tier is 1 e2-micro in us-east1
  use the gcp free tier and $300 credit https://cloud.google.com/free/docs/free-cloud-features#free-tier-usage-limits
