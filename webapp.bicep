param location string = 'italynorth'
param appServicePlanName string = 'avlin-automated-bicepAppServicePlan1'
param webAppName string = 'avlin-automated-bicepWebAppDemo1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}