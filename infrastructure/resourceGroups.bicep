targetScope = 'subscription'

@description('The location for all the resources; use the short strings from https://azuretracks.com/2021/04/current-azure-region-names-reference/')
param targetLocation string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'qa-Time'
  location: targetLocation
}


