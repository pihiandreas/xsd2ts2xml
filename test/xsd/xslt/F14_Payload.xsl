<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="RequestInvoiceDataTemplate" match="//*[local-name()='Transaction']">
       <_name>RequestInvoiceData</_name>
       <_type>F14_RET</_type>
       <xsl:element name="InvoicingPeriodStartTime">
           <xsl:value-of select="./*[local-name()='InvoicingPeriod']/*[local-name()='Start']" />
       </xsl:element>
       <xsl:element name="InvoicingPeriodEndTime">
           <xsl:value-of select="./*[local-name()='InvoicingPeriod']/*[local-name()='End']" />
       </xsl:element>
       <xsl:element name="MeteringPointEAN">
           <xsl:value-of select="./*[local-name()='MeteringPoint']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='AuthorContract']">
       <xsl:element name="AuthorAgreementIdentification">
           <xsl:value-of select="./*[local-name()='AuthorContract']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='RecipientContract']">
       <xsl:element name="RecipientAgreementIdentification">
           <xsl:value-of select="./*[local-name()='RecipientContract']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='AuthorPartyIdentification']">
       <xsl:element name="AuthorPartyIdentification">
           <xsl:value-of select="./*[local-name()='AuthorPartyIdentification']" />
       </xsl:element>
       </xsl:if>
       <xsl:if test="./*[local-name()='RecipientPartyIdentification']">
       <xsl:element name="RecipientPartyIdentification">
           <xsl:value-of select="./*[local-name()='RecipientPartyIdentification']" />
       </xsl:element>
       </xsl:if>

</xsl:template>
</xsl:stylesheet>
