locals {
  query = <<-EOQ
select
  name,
  arn,
  region,
  account_id,
  sp_connection_name as conn
from
  aws_s3_bucket
where
  tags is null;
  EOQ
}