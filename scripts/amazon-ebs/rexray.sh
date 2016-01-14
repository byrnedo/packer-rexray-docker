sudo curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -
sudo tee -a /etc/rexray/config.yml << EOF
rexray:
  logLevel: warn
  storageDrivers:
  - ec2
aws:
  accessKey: MyAccessKey
  secretKey: MySecretKey
EOF
