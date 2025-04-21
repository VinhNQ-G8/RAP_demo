@EndUserText.label: 'Consumption View for Allocation Detail'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['ItemNo']

define view entity ZC_ALLOC_DETAIL
//  provider contract transactional_query
  as projection on ZI_ALLOC_DETAIL
{
  key AllocationId,
  
  @ObjectModel.text.element: ['ItemNo']
  key ItemNo,
  
      @Semantics.amount.currencyCode: 'Currency'
      Amount,
      
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      Currency,
      
//      @Semantics.quantity.unitOfMeasure: 'KBETR'
      TaxRate,
      
      Note,
      
      /* Associations */
      _Header : redirected to parent ZC_ALLOC_HEADER,
      _Items : redirected to composition child ZC_ALLOC_ITEM
} 
