@EndUserText.label: 'Consumption View for Allocation Items'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['ItemNo', 'AllocNo']
@Search.searchable: true

define view entity ZC_ALLOC_ITEM
  provider contract transactional_query
  as projection on ZI_ALLOC_ITEM
{
  key AllocationId,
  
  @ObjectModel.text.element: ['ItemNo']
  key ItemNo,
  
  @ObjectModel.text.element: ['AllocNo']
  key AllocNo,
  
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_MaterialVH', element: 'Material' }}]
      Material,
      
      @Semantics.quantity.unitOfMeasure: 'Unit'
      Quantity,
      
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_UnitOfMeasure', element: 'UnitOfMeasure' }}]
      Unit,
      
      @Semantics.amount.currencyCode: 'Currency'
      Amount,
      
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      Currency,
      
      /* Associations */
      _Detail : redirected to parent ZC_ALLOC_DETAIL,
      _Header : redirected to ZC_ALLOC_HEADER
} 