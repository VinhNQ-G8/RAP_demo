@EndUserText.label: 'Consumption View for Allocation Header'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['InvoiceNo']
@Search.searchable: true
@UI: {
  headerInfo: {
    typeName: 'Allocation',
    typeNamePlural: 'Allocations',
    title: { type: #STANDARD, value: 'InvoiceNo' }
  }
}

define root view entity ZC_ALLOC_HEADER
  as projection on ZI_ALLOC_HEADER
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
  key AllocationId,

      @UI: {
        lineItem:       [ { position: 10 } ],
        identification: [ { position: 10 } ],
        selectionField: [ { position: 10 } ]
      }
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      InvoiceNo,

      @UI: {
        lineItem:       [ { position: 20 } ],
        identification: [ { position: 20 } ],
        selectionField: [ { position: 20 } ]
      }
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_PostingDate', element: 'PostingDate' }}]
      PostingDate,

      @UI: {
        lineItem:       [ { position: 30 } ],
        identification: [ { position: 30 } ]
      }
      @Semantics.amount.currencyCode: 'Currency'
      TotalAmount,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      @UI: {
        lineItem:       [ { position: 40 } ],
        identification: [ { position: 40 } ]
      }
      Currency,

      @UI: {
        lineItem:       [ { position: 50 } ],
        identification: [ { position: 50 } ]
      }
      @Semantics.user.createdBy: true
      CreatedBy,

      @UI: {
        identification: [ { position: 60 } ]
      }
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Associations */
      _Details : redirected to composition child ZC_ALLOC_DETAIL
} 