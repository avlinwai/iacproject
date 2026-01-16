pipeline {
    agent any

    environment {
        // These values come from Jenkins credentials you already added
        ARM_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('AZURE_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
        RESOURCE_GROUP        = 'IaCLab-Avlin'
        TEMPLATE_FILE         = 'webapp.bicep'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/your-org/your-repo.git'
            }
        }

        stage('Login to Azure') {
            steps {
                bat '''
                az login --service-principal \
                  --username $AZURE_CLIENT_ID \
                  --password $AZURE_CLIENT_SECRET \
                  --tenant $AZURE_TENANT_ID
                az account set --subscription $AZURE_SUBSCRIPTION_ID
                '''
            }
        }

        stage('Deploy Bicep Template') {
            steps {
                bat '''
                az deployment group create \
                  --resource-group $RESOURCE_GROUP \
                  --template-file $TEMPLATE_FILE \
                  --verbose
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Check Azure Portal for resources."
        }
        failure {
            echo "❌ Deployment failed. Review Jenkins logs."
        }
    }
}