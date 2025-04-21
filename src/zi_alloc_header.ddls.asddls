@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Allocation Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_ALLOC_HEADER
  as select from zalloc_header
  composition [0..*] of ZI_ALLOC_DETAIL as _Details
{
  key alloc_id              as AllocationId,
      invoice_no            as InvoiceNo,
      posting_date          as PostingDate,
      @Semantics.amount.currencyCode: 'Currency'
      total_amount          as TotalAmount,
      //      @Semantics.currencyCode: true
      currency              as Currency,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Associations */
      _Details
}
