@description('Deployment environment prefix; either qa or prod. lowercase')
param environment string

@description('The location for all the resources; use the short strings from https://azuretracks.com/2021/04/current-azure-region-names-reference/')
param targetLocation string

resource timeStorage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: '${environment}timestorage'
  location: targetLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'BlobStorage'
  extendedLocation: null
  identity: null /* {
    type: 'string'
    userAssignedIdentities: {}
  } */
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: null
    allowedCopyScope: null
    allowSharedKeyAccess: null
    /*
    azureFilesIdentityBasedAuthentication: {
      activeDirectoryProperties: {
        accountType: 'string'
        azureStorageSid: 'string'
        domainGuid: 'string'
        domainName: 'string'
        domainSid: 'string'
        forestName: 'string'
        netBiosDomainName: 'string'
        samAccountName: 'string'
      }
      defaultSharePermission: 'string'
      directoryServiceOptions: 'string'
    }
    */
    customDomain: null
    defaultToOAuthAuthentication: null
    dnsEndpointType: null
    encryption: {
      identity: null
      keySource: 'Microsoft.Storage'
      keyvaultproperties: null
      requireInfrastructureEncryption: null
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        queue: null
        table: null
      }
    }
    immutableStorageWithVersioning: {
      enabled: false
      immutabilityPolicy: null
    }
    isHnsEnabled: null
    isLocalUserEnabled: null
    // isNfsV3Enabled: bool
    // isSftpEnabled: bool
    keyPolicy: null
    largeFileSharesState: null
    minimumTlsVersion: 'TLS1_0'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: null
      virtualNetworkRules: []
    }
    publicNetworkAccess: null
    routingPreference: null
    sasPolicy: null
    supportsHttpsTrafficOnly: true
  }
}
