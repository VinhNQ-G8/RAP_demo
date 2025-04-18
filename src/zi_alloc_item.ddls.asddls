@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Allocation Items'
define view entity ZI_ALLOC_ITEM
  as select from zalloc_item
  association to parent ZI_ALLOC_DETAIL as _Detail
    on  $projection.AllocationId = _Detail.AllocationId
    and $projection.ItemNo      = _Detail.ItemNo
  association to ZI_ALLOC_HEADER as _Header
    on $projection.AllocationId = _Header.AllocationId
{
  key alloc_id     as AllocationId,
  key item_no      as ItemNo,
  key alloc_no     as AllocNo,
      material     as Material,
      quantity     as Quantity,
      @Semantics.unitOfMeasure: true
      unit         as Unit,
      amount       as Amount,
      @Semantics.currencyCode: true
      currency     as Currency,
      
      /* Associations */
      _Detail,
      _Header
} 