<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:uuid="java:java.util.UUID"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
<xsl:template name="TransactionTemplate" match="//*[local-name()='Transaction']">
    <_entities_element>
        <_name>Transaction</_name>
        <_type>TRANSACTION</_type>
        <xsl:if test="./*[local-name()='TransactionIdentification']">
            <ExternalTransactionID>
                <xsl:value-of select="./*[local-name()='TransactionIdentification']" />
            </ExternalTransactionID>
        </xsl:if>
        <xsl:if	test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
            <ExternalTransactionType>
                <xsl:value-of
                    select="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
            </ExternalTransactionType>
        </xsl:if>
        <_entities>
            <_entities_element>
                <_name>TransactionHeader</_name>
                <_type>TRANSACTION_HEADER</_type>
                <xsl:if test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
                    <InternalTransactionType>
                        <xsl:choose>
                            <xsl:when test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-731-1'">IVR.CRS</xsl:when>
                            <xsl:when test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-732-1'">IVR.CRD</xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </InternalTransactionType>
                </xsl:if>
                <xsl:if test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
                    <PayloadType>
                        <xsl:choose>
                            <xsl:when test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-731-1'">IVR.CRS.REQ</xsl:when>
                            <xsl:when test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-732-1'">IVR.CRD.REQ</xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </PayloadType>
                </xsl:if>
                <InternalTransactionID>
                    <xsl:value-of select="uuid:randomUUID()" />
                </InternalTransactionID>
            </_entities_element>
            <_entities_element>
                <_name>Payload</_name>
                <_type>PAYLOAD</_type>
				<_entities>
					<_entities_element>
						<_name>InvoiceData</_name>
						<_type>F13_IVD</_type>
						<xsl:element name="TransactionIdentification">
							<xsl:value-of select="./*[local-name()='TransactionIdentification']" />
						</xsl:element>
						<xsl:element name="MeteringPointEAN">
							<xsl:value-of select="./*[local-name()='MeteringPoint']" />
						</xsl:element>
						<xsl:element name="AuthorAgreementIdentification">
							<xsl:value-of select="./*[local-name()='AuthorContract']" />
						</xsl:element>
						<xsl:if test="./*[local-name()='RecipientContract']">
						<xsl:element name="RecipientAgreementIdentification">
							<xsl:value-of select="./*[local-name()='RecipientContract']" />
						</xsl:element>
						</xsl:if>
						<xsl:element name="AuthorPartyIdentification">
							<xsl:value-of select="./*[local-name()='AuthorPartyIdentification']" />
						</xsl:element>
						<xsl:element name="RecipientPartyIdentification">
							<xsl:value-of select="./*[local-name()='RecipientPartyIdentification']" />
						</xsl:element>
						<xsl:element name="InvoiceIdentifier">
							<xsl:value-of select="./*[local-name()='InvoicingPeriod']/*[local-name()='InvoiceIdentification']" />
						</xsl:element>
						<xsl:element name="InvoiceCreationDate">
							<xsl:value-of select="replace(./*[local-name()='InvoicingPeriod']/*[local-name()='InvoiceCreationDate'], '\+00:00', 'Z')"/> 
						</xsl:element>
						<xsl:element name="InvoicingPeriodStartTime">
							<xsl:value-of select="replace(./*[local-name()='InvoicingPeriod']/*[local-name()='Start'], '\+00:00', 'Z')"/> 
						</xsl:element>
						<xsl:element name="InvoicingPeriodEndTime">
							<xsl:value-of select="replace(./*[local-name()='InvoicingPeriod']/*[local-name()='End'], '\+00:00', 'Z')"/> 
						</xsl:element>

						<_entities>
								<xsl:apply-templates />
						</_entities>
					</_entities_element>
				</_entities>
			</_entities_element>	
		</_entities>
     </_entities_element>
</xsl:template>
<xsl:template name="InvoiceRowTemplate" match="//*[local-name()='InvoicingRow']">
<_entities_element>
       <_name>InvoiceRow</_name>
       <_type>F13_IVR</_type>
       <xsl:if test="./*[local-name()='RowIdentification']">
       <xsl:element name="InvoiceRowIdentifier">
           <xsl:value-of select="./*[local-name()='RowIdentification']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="ProductCode">
           <xsl:value-of select="./*[local-name()='ProductIdentification']" />
       </xsl:element>
       <xsl:element name="ProductComponentCode">
           <xsl:value-of select="./*[local-name()='ProductComponentIdentification']" />
       </xsl:element>
       <xsl:element name="Price">
           <xsl:value-of select="./*[local-name()='Price']" />
       </xsl:element>
       <xsl:element name="PriceUnit">
           <xsl:value-of select="./*[local-name()='PriceUnit']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='PriceUnitCode']">
       <xsl:element name="PriceUnitIdentification">
           <xsl:value-of select="./*[local-name()='PriceUnitCode']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="Currency">
           <xsl:value-of select="./*[local-name()='Currency']" />
       </xsl:element>
       <xsl:element name="IsPriceTaxIncluded">
           <xsl:choose>
               <xsl:when test="./*[local-name()='TaxIncluded']='0' or ./*[local-name()='TaxIncluded']='false'">false</xsl:when>
               <xsl:otherwise>true</xsl:otherwise>
           </xsl:choose>
       </xsl:element>
       <xsl:element name="Quantity">
           <xsl:value-of select="./*[local-name()='Volume']" />
       </xsl:element>
       <xsl:element name="QuantityUnit">
           <xsl:value-of select="./*[local-name()='VolumeUnit']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='VolumeUnitCode']">
       <xsl:element name="QuantityUnitIdentification">
           <xsl:value-of select="./*[local-name()='VolumeUnitCode']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="InvoiceRowTotal">
           <xsl:value-of select="./*[local-name()='Amount']" />
       </xsl:element>
       <xsl:if test="./*[local-name()='Description']">
       <xsl:element name="Description">
           <xsl:value-of select="./*[local-name()='Description']" />
       </xsl:element>
       </xsl:if>
       <xsl:element name="VATPercentage">
           <xsl:value-of select="./*[local-name()='Tax']" />
       </xsl:element>
       <xsl:element name="InvoiceRowStartTime">
			<xsl:value-of select="replace(./*[local-name()='Start'], '\+00:00', 'Z')"/>
       </xsl:element>
       <xsl:element name="InvoiceRowEndTime">
			<xsl:value-of select="replace(./*[local-name()='End'], '\+00:00', 'Z')"/>
       </xsl:element>
  </_entities_element>
</xsl:template>
</xsl:stylesheet>
