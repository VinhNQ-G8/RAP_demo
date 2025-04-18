@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Allocation Header'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['InvoiceNo']
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
@UI: {
  headerInfo: {
    typeName: 'Allocation',
    typeNamePlural: 'Allocations',
    title: { type: #STANDARD, value: 'InvoiceNo' }
  }
}

define root view entity ZC_ALLOC_HEADER 
  as projection on ZI_ALLOC_HEADER as Header
{
    @UI.facet: [
      { id:            'Header',
        purpose:       #STANDARD,
        type:         #IDENTIFICATION_REFERENCE,
        label:        'General Information',
        position:     10 },
      { id:            'Details',
        purpose:       #STANDARD,
        type:         #LINEITEM_REFERENCE,
        label:        'Details',
        position:     20,
        targetElement: '_Details'}
    ]

    @UI.hidden: true
key Header.AllocationId as AllocationId,

    @UI: {
      lineItem:       [ { position: 10, importance: #HIGH } ],
      identification: [ { position: 10 } ],
      selectionField: [ { position: 10 } ]
    }
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Header.InvoiceNo as InvoiceNo,

    @UI: {
      lineItem:       [ { position: 20 } ],
      identification: [ { position: 20 } ],
      selectionField: [ { position: 20 } ]
    }
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_PostingDate', element: 'PostingDate' }}]
    Header.PostingDate as PostingDate,

    @UI: {
      lineItem:       [ { position: 30 } ],
      identification: [ { position: 30 } ]
    }
    @Semantics.amount.currencyCode: 'Currency'
    Header.TotalAmount as TotalAmount,

    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
    @UI: {
      lineItem:       [ { position: 40 } ],
      identification: [ { position: 40 } ]
    }
    Header.Currency as Currency,

    @UI: {
      lineItem:       [ { position: 50 } ],
      identification: [ { position: 50 } ]
    }
    @Semantics.user.createdBy: true
    Header.CreatedBy as CreatedBy,

    @UI: {
      identification: [ { position: 60 } ]
    }
    @Semantics.systemDateTime.createdAt: true
    Header.CreatedAt as CreatedAt,

    @Semantics.systemDateTime.lastChangedAt: true
    Header.LastChangedAt as LastChangedAt,

    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    Header.LocalLastChangedAt as LocalLastChangedAt,

    /* Associations */
    _Details : redirected to composition child ZC_ALLOC_DETAIL
} 