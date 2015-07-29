:aws:
  :access_key_id: {{AWS_ACCESS_KEY}}
  :secret_access_key: {{AWS_SECRET_KEY}}
:s3:
  :region: {{S3_REGION}} # S3 bucket region
  :buckets:
    :jsonpath_assets: {{JSONPATH_ASSETS }} # If you have defined your own JSON Schemas, add the s3:// path to your own JSON Path files in your own bucket here
    :enriched:
      :good:    {{ENRICHED_GOOD}} # Must be s3 not s3n for Redshift. This is the same as the enriched good bucket specified for EmrEtlRunner
      :archive: {{ENRICHED_ARCHIVE}} # Where to archive enriched events to
    :shredded:
      :good: {{SHREDDED_GOOD}} # Must be s3 not s3n for Redshift. This is same shredded good for EmrEtlRunn
      :archive: {{SHREDDED_ARCHIVE}} # Where to archive shredded types to
:download:
  :folder: # Not required for Redshift
:targets:
  - :name: {{ TARGET_NAME | default("My Redshift database") }}
    :type: redshift
    :host: {{TARGETS_HOST}} # The endpoint as shown in the Redshift console
    :database: {{TARGETS_DATABASE}} # Name of database
    :port: {{TARGETS_PORT}} # Default Redshift port
    :table: {{TARGETS_TABLE}}
    :username: {{TARGETS_USERNAME}}
    :password: {{TARGETS_PASSWORD}}
    :maxerror: {{ MAXERROR | default(1) }}  # Stop loading on first error, or increase to permit more load errors
    :comprows: 200000 # Default for a 1 XL node cluster. Not used unless --include compupdate specified

