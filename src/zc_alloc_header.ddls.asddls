@EndUserText.label: 'Consumption View for Allocation Header'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true


define root view entity ZC_ALLOC_HEADER
  provider contract transactional_query
  as projection on ZI_ALLOC_HEADER as Header
{
  key Header.AllocationId       as AllocationId,
      Header.InvoiceNo          as InvoiceNo,
      Header.PostingDate        as PostingDate,
      @Semantics.amount.currencyCode: 'Currency'
      Header.TotalAmount        as TotalAmount,
      Header.Currency           as Currency,
      @Semantics.user.createdBy: true
      Header.CreatedBy          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Header.CreatedAt          as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      Header.LastChangedAt      as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Header.LocalLastChangedAt as LocalLastChangedAt,
      /* Associations */
      _Details : redirected to composition child ZC_ALLOC_DETAIL
}
