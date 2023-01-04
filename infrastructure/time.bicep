@description('Deployment environment prefix; either qa or prod. lowercase')
param environment string

@description('The location for all the resources; use the short strings from https://azuretracks.com/2021/04/current-azure-region-names-reference/')
param targetLocation string = resourceGroup().location

var timeStorageName = '${environment}timestorage'
resource timeStorage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: timeStorageName
  location: targetLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

var functionAppName = '${environment}timefunction'
resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  location: targetLocation
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${timeStorageName};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${timeStorage.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${timeStorageName};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${timeStorage.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~18'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'node'
        }
      ]
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}
