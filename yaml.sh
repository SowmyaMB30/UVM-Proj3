python3.9 $UVMF_HOME/scripts/yaml2uvmf.py --dest_dir . \
  $(find verification_ip/interface_packages/ -type f -name "*.yaml") \
  $(find verification_ip/environment_packages/ -type f -name "*.yaml")