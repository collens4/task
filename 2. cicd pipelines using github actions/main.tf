name: 'Terraform'

on:
  push:
    branches:
    - main
  pull_request:

jobs:
  terraform:
    name: 'Terraform'
    env:
      ARM_CLIENT_ID: ${{ secrets.AZURE_AD_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.AZURE_AD_CLIENT_SECRET }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.AZURE_AD_TENANT_ID }}
    runs-on: ubuntu-latest
    environment: dev

    defaults:
      run:
        shell: bash

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: 'Terraform Format'
      uses: hashicorp/terraform-github-actions@master
      with:
        tf_actions_version: 0.14.8
        tf_actions_subcommand: 'fmt'
        tf_actions_working_dir: "./terraform"
        
    - name: 'Terraform Init'
      uses: hashicorp/terraform-github-actions@master
      with:
        tf_actions_version: 0.14.8
        tf_actions_subcommand: 'init'
        tf_actions_working_dir: "./terraform"

    - name: 'Terraform Validate'
      uses: hashicorp/terraform-github-actions@master
      with:
        tf_actions_version: 0.14.8
        tf_actions_subcommand: 'validate'
        tf_actions_working_dir: "./terraform"
        
    - name: 'Terraform Plan'
      uses: hashicorp/terraform-github-actions@master
      with:
        tf_actions_version: 0.14.8
        tf_actions_subcommand: 'plan'
        tf_actions_working_dir: "./terraform"

    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      uses: hashicorp/terraform-github-actions@master
      with:
        tf_actions_version: 0.14.8
        tf_actions_subcommand: 'apply'
        tf_actions_working_dir: "./terraform"
