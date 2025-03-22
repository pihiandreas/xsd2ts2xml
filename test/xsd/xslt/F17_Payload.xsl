<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />

<xsl:template name="TransactionTemplate" match="//*[local-name()='Transaction']">

  <xsl:apply-templates select="//*[local-name()='PartyInfo']" />
  <xsl:apply-templates select="//*[local-name()='PartyType']" />

</xsl:template>	

<xsl:template name="PartyInfoTemplate" match="//*[local-name()='PartyInfo']">


		<_entities_element>
			<_name>Organisation</_name>
				<_type>F17_ORG</_type>
				<xsl:element name="OrganisationIdentifier">
					<xsl:value-of select="./*[local-name()='PartyIdentification']" />
				</xsl:element>				
		</_entities_element>

</xsl:template>	

<xsl:template name="PartyTypeTemplate" match="//*[local-name()='PartyType']">
		<_entities_element>
				<_name>MarketRole</_name>
				<_type>F17_MRL</_type>
				<xsl:element name="MarketRole">
					<xsl:choose>
						<xsl:when test=".='AS01'">DDQ</xsl:when>
						<xsl:when test=".='AS02'">DSO</xsl:when>
						<xsl:when test=".='AS03'">THP</xsl:when>
						<xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
					</xsl:choose>
				</xsl:element>							
		</_entities_element>


</xsl:template>	

</xsl:stylesheet>
