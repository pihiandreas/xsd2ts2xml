<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
	<xsl:template name="NEGPartyMasterDataDocumentTemplate" match="//*[local-name()='NEGPartyMasterDataDocument']">
		<_entities_element>
			<entity>
				<_name>Header</_name>
				<_type>Z18_HSM</_type>
				<xsl:element name="DocumentType">
					<xsl:value-of select="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='DocumentType']/@v" />
				</xsl:element>
				<xsl:element name="ProcessType">
					<xsl:value-of select="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='ProcessType']/@v" />
				</xsl:element>
				<xsl:element name="SenderRole">
					<xsl:value-of select="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='SenderRole']/@v" />
				</xsl:element>
				<xsl:element name="ReceiverRole">
					<xsl:value-of select="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='ReceiverRole']/@v" />
				</xsl:element>
				<xsl:element name="CreationDateTime">
					<xsl:value-of select="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='CreationDateTime']/@v" />
				</xsl:element>
			</entity>
		</_entities_element>

	</xsl:template>
	<xsl:template name="BalanceResponsibilityTemplate" match="//*[local-name()='NEGPartyMasterDataDocument']/*[local-name()='PartyDetails']/*[local-name()='RelatedParty']">
		<_entities_element>
			<entity>
				<xsl:if test="./*[local-name()='RelatedParty']">
					<_name>BalanceResponsibility</_name>
					<_type>Z18_BAR</_type>

					<xsl:element name="SupplierIdentifier">
						<xsl:value-of select="./*[local-name()='RelatedParty']/@v" />
					</xsl:element>

					<xsl:if test="../*[local-name()='SubjectParty']">
						<xsl:element name="BalanceResponsiblePartyIdentifier">
							<xsl:value-of select="../*[local-name()='SubjectParty']/@v" />
						</xsl:element>
					</xsl:if>
					<xsl:if test="../*[local-name()='MeteringGridAreaIdentification']">
						<xsl:element name="MeteringGridAreaCode">
							<xsl:value-of select="../*[local-name()='MeteringGridAreaIdentification']/@v" />
						</xsl:element>
					</xsl:if>
					<xsl:if test="../*[local-name()='BusinessType']">
						<xsl:element name="BusinessType">
							<xsl:value-of select="../*[local-name()='BusinessType']/@v" />
						</xsl:element>
					</xsl:if>
					<xsl:if test="../*[local-name()='ValidityStart']">
						<xsl:element name="ValidFromDate">
							<xsl:value-of select="replace(../*[local-name()='ValidityStart']/@v, '\+00:00', 'Z')" />
						</xsl:element>
					</xsl:if>
					<xsl:if test="../*[local-name()='ValidityEnd']">
						<xsl:element name="ValidToDate">
							<xsl:value-of select="replace(../*[local-name()='ValidityEnd']/@v, '\+00:00', 'Z')" />
						</xsl:element>
					</xsl:if>
				</xsl:if>
			</entity>
		</_entities_element>
	</xsl:template>
</xsl:stylesheet>