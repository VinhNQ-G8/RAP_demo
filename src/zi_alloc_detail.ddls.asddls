@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Allocation Detail'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ALLOC_DETAIL
  as select from zalloc_detail
  composition [0..*] of ZI_ALLOC_ITEM as _Items
  association to parent ZI_ALLOC_HEADER as _Header
    on $projection.AllocationId = _Header.AllocationId
{
  key alloc_id     as AllocationId,
  key item_no      as ItemNo,
      @Semantics.amount.currencyCode: 'Currency'
      amount       as Amount,
      @Semantics.currencyCode: true
      currency     as Currency,
      tax_rate     as TaxRate,
      note         as Note,
      
      /* Associations */
      _Header,
      _Items
} 