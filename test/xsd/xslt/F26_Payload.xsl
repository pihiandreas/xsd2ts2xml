<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<!--
 Set variable ProcesTypeUPS to check determine process type and use in transformations
-->
	<xsl:variable name="ProcesType" select="//*[local-name()='EnergyBusinessProcess']"/>
	<xsl:template name="EnergyCommunityTemplate" match="//*[local-name()='Transaction']">
		<_name>EnergyCommunity</_name>
		<xsl:choose>
			<xsl:when test="$ProcesType='DH-143'">
				<_type>F26_ECY_END</_type>
			</xsl:when>
			<xsl:otherwise>
				<_type>F26_ECY</_type>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:element name="EnergyCommunityIdentifier">
			<xsl:value-of select="./*[local-name()='EnergyCommunityIdentification']"/>
		</xsl:element>
		<xsl:if test="./*[local-name()='EnergyCommunityName']">
			<xsl:element name="EnergyCommunityName">
				<xsl:value-of select="./*[local-name()='EnergyCommunityName']"/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="./*[local-name()='SurplusMethod']">
			<xsl:element name="SurplusMethod">
				<xsl:value-of select="./*[local-name()='SurplusMethod']"/>
			</xsl:element>
		</xsl:if>		
		<_entities>
			<xsl:apply-templates/>
		</_entities>
	</xsl:template>
	<xsl:template name="ConsumptionMemberTemplate" match="//*[local-name()='ConsAccountingPoints']">
		<_entities_element>
			<entity>
				<_name>ConsumptionMember</_name>
				<_type>F26_CAP</_type>
				<xsl:element name="MeteringPointEAN">
					<xsl:value-of select="./*[local-name()='AccountingPointIdentification']"/>
				</xsl:element>
				<xsl:element name="Percentage">
					<xsl:value-of select="./*[local-name()='Percentage']"/>
				</xsl:element>
				<_entities>
					<xsl:apply-templates/>
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="ProductionMemberTemplate" match="//*[local-name()='SSProdAccountingPoints']">
		<_entities_element>
			<entity>
				<_name>ProductionMember</_name>
				<_type>F26_PAP</_type>
				<xsl:element name="MeteringPointEAN">
					<xsl:value-of select="./*[local-name()='AccountingPointIdentification']"/>
				</xsl:element>
				<xsl:element name="IsSurplus">
					<xsl:choose>
						<xsl:when test="./*[local-name()='IsSurplus']='0' or ./*[local-name()='IsSurplus']='false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<_entities>
					<xsl:apply-templates/>
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
</xsl:stylesheet>
