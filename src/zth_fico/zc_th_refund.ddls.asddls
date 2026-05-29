@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Refund CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TH_REFUND
  provider contract transactional_query
  as projection on ZI_TH_REFUND
{
  key RefundId,
      BookingId,
      CustomerId,
      RefundDate,
      RefundAmount,
      RefundReason,
      Status,
      CurrencyCode,
      ApprovedBy,
      ApprovedAt,
      CreatedBy,
      CreatedAt,
      LocalLastchangedBy,
      LocalLastchangedAt,
      /* Associations */
      _Booking
}
