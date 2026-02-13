param location string = resourceGroup().location
param logAnalyticsName string
param storageAccountName string
param serviceBusNamespaceName string

// =============================
// Log Analytics Workspace
// =============================
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

// =============================
// Storage Account (Secure Baseline)
// =============================
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
}

// =============================
// Service Bus Namespace
// =============================
resource serviceBus 'Microsoft.ServiceBus/namespaces@2023-01-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {}
}

// =============================
// Managed Identity
// =============================
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'platform-mi'
  location: location
}

// =============================
// RBAC Assignment (Storage Blob Data Contributor)
// =============================
//resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//  name: guid(storage.id, managedIdentity.id, 'blob-role')
//  scope: storage
//  properties: {
//    roleDefinitionId: subscriptionResourceId(
//      'Microsoft.Authorization/roleDefinitions',
//      'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
//    )
//    principalId: managedIdentity.properties.principalId
//  }
//}

// =============================
// Diagnostic Settings → Log Analytics
// =============================
//resource diagnostic 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
//  name: 'storage-diagnostics'
//  scope: storage
//  properties: {
//    workspaceId: logAnalytics.id
//    logs: [
//      {
//        categoryGroup: 'allLogs'
//        enabled: true
//      }
//    ]
//    metrics: [
//      {
//        category: 'AllMetrics'
//        enabled: true
//      }
//    ]
//  }
//}

