@EndUserText.label: 'Consumption View for Allocation Header'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_ALLOC_HEADER
  as projection on ZI_ALLOC_HEADER
{
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
      CreatedBy,
      CreatedAt,
      LastChangedAt,
      LocalLastChangedAt,
      
      /* Associations */
      _Details : redirected to composition child ZC_ALLOC_DETAIL
} 