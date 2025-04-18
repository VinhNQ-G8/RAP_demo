@EndUserText.label: 'Consumption View for Allocation Header'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['InvoiceNo']
@Search.searchable: true

define root view entity ZC_ALLOC_HEADER
  provider contract transactional_query
  as projection on ZI_ALLOC_HEADER
{
      @ObjectModel.text.element: ['InvoiceNo']
  key AllocationId,
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      InvoiceNo,
      
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_PostingDate', element: 'PostingDate' }}]
      PostingDate,
      
      @Semantics.amount.currencyCode: 'Currency'
      TotalAmount,
      
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      Currency,
      
      @Semantics.user.createdBy: true
      CreatedBy,
      
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      
      /* Associations */
      _Details : redirected to composition child ZC_ALLOC_DETAIL
} 