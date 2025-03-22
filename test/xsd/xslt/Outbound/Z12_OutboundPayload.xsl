<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
	xmlns:urn17="urn:ediel:org:masterdata:partymasterdatadocument:1:2">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"	indent="no" />
	<xsl:template match="entity">
		<urn17:NEGPartyMasterDataDocument>
			<xsl:if test="ExternalMessageID">
				<urn17:DocumentIdentification>
					<xsl:attribute name="v"><xsl:value-of select="ExternalMessageID"/></xsl:attribute>
				</urn17:DocumentIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HSM']/DocumentType">
				<urn17:DocumentType>
					<xsl:attribute name="v"><xsl:value-of select=".//*[_type='HSM']/DocumentType"/></xsl:attribute>
				</urn17:DocumentType>
			</xsl:if>
			<xsl:if test=".//*[_type='HSM']/ProcessType">
				<urn17:ProcessType>
					<xsl:attribute name="v"><xsl:value-of select=".//*[_type='HSM']/ProcessType"/></xsl:attribute>
				</urn17:ProcessType>
			</xsl:if>
			<xsl:if test="JuridicalSender">
				<urn17:SenderIdentification>
					<xsl:attribute name="v"><xsl:value-of select="JuridicalSender"/></xsl:attribute>
					<xsl:attribute name="codingScheme">A10</xsl:attribute>
				</urn17:SenderIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HSM']/SenderRole">
				<urn17:SenderRole>
					<xsl:attribute name="v"><xsl:value-of select=".//*[_type='HSM']/SenderRole"/></xsl:attribute>
				</urn17:SenderRole>
			</xsl:if>
			<xsl:if test="JuridicalReceiver">
				<urn17:ReceiverIdentification>
					<xsl:attribute name="v"><xsl:value-of select="JuridicalReceiver"/></xsl:attribute>
					<xsl:attribute name="codingScheme">A01</xsl:attribute>
				</urn17:ReceiverIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HSM']/ReceiverRole">
				<urn17:ReceiverRole>
					<xsl:attribute name="v"><xsl:value-of select=".//*[_type='HSM']/ReceiverRole"/></xsl:attribute>
				</urn17:ReceiverRole>
			</xsl:if>
			<xsl:if test=".//*[_type='HSM']/CreationDateTime">
				<urn17:CreationDateTime>
					<xsl:attribute name="v"><xsl:value-of select=".//*[_type='HSM']/CreationDateTime"/></xsl:attribute>
				</urn17:CreationDateTime>
			</xsl:if>
			<xsl:for-each select=".//*[_type='BSC']">
				<urn17:PartyDetails>
					<xsl:if test="SupplierIdentifier">
						<urn17:SubjectParty>
							<xsl:attribute name="v"><xsl:value-of select="SupplierIdentifier"/></xsl:attribute>
							<xsl:attribute name="codingScheme">A10</xsl:attribute>
						</urn17:SubjectParty>
					</xsl:if>
					<xsl:if test="SubjectPartyRole">
						<urn17:SubjectPartyRole>
							<xsl:attribute name="v"><xsl:value-of select="SubjectPartyRole"/></xsl:attribute>
						</urn17:SubjectPartyRole>
					</xsl:if>
					<xsl:if test="MeteringGridAreaCode">
						<urn17:MeteringGridAreaIdentification>
							<xsl:attribute name="v"><xsl:value-of select="MeteringGridAreaCode"/></xsl:attribute>
							<xsl:attribute name="codingScheme">A01</xsl:attribute>
						</urn17:MeteringGridAreaIdentification>
					</xsl:if>
					<xsl:if test="Status">
						<urn17:Status>
							<xsl:attribute name="v"><xsl:value-of select="Status"/></xsl:attribute>
						</urn17:Status>
					</xsl:if>
					<xsl:if test="ValidFromDate and IsActive = 'true'">
						<urn17:ValidityStart>
							<xsl:attribute name="v"><xsl:value-of select="ValidFromDate"/></xsl:attribute>
						</urn17:ValidityStart>
					</xsl:if>
					<xsl:if test="ValidFromDate and IsActive = 'false'">
						<urn17:ValidityEnd>
							<xsl:attribute name="v"><xsl:value-of select="ValidFromDate"/></xsl:attribute>
						</urn17:ValidityEnd>
					</xsl:if>
					<xsl:if test="ValidToDate">
						<urn17:ValidityEnd>
							<xsl:attribute name="v"><xsl:value-of select="ValidToDate"/></xsl:attribute>
						</urn17:ValidityEnd>
					</xsl:if>		
					<xsl:if test="BusinessType">
						<urn17:BusinessType>
							<xsl:attribute name="v"><xsl:value-of select="BusinessType"/></xsl:attribute>
						</urn17:BusinessType>
					</xsl:if>
					<xsl:if test="SettlementMethod">
						<urn17:SettlementMethod>
							<xsl:attribute name="v"><xsl:value-of select="SettlementMethod"/></xsl:attribute>
						</urn17:SettlementMethod>
					</xsl:if>
				</urn17:PartyDetails>
			</xsl:for-each>
		</urn17:NEGPartyMasterDataDocument>
	</xsl:template>
</xsl:stylesheet>