targetScope = 'subscription'

@description('The location for all the resources; use the short strings from https://azuretracks.com/2021/04/current-azure-region-names-reference/')
param targetLocation string

@description('Deployment environment prefix; either qa or prod')
param environment string

resource timeResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${environment}-Time'
  location: targetLocation
}

module time 'time.bicep' = {
  name: 'timeModule'
  scope: timeResourceGroup
  params: {
    targetLocation: targetLocation
    environment: environment
  }
}
