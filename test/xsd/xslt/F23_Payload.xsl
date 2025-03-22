<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />

	<xsl:template name="ProductComponentTemplate" match="//*[local-name()='Transaction']">
		<_name>ProductComponent</_name>
		<_type>F23_PCP</_type>
		<xsl:if test="//*[local-name()='Transaction']/*[local-name()='ProductOwner']">
			<xsl:element name="OrganisationIdentifier">
				<xsl:value-of select="//*[local-name()='Transaction']/*[local-name()='ProductOwner']" />
			</xsl:element>
		</xsl:if>      
		<xsl:element name="ProductCode">
			<xsl:value-of select="//*[local-name()='Transaction']/*[local-name()='ProductIdentification']" />
		</xsl:element>	
		<xsl:element name="ProductComponentCode">
			<xsl:value-of select="//*[local-name()='Transaction']/*[local-name()='ProductComponentIdentification']" />
		</xsl:element>	   

		<_entities>
			<xsl:apply-templates />
		</_entities>
	</xsl:template>
	<xsl:template name="CalendarTimeSeriesTemplate" match="//*[local-name()='Transaction']/*[local-name()='CalendarTimeSeries']">
		<_entities_element>
			<entity>
				<_name>CalendarTimeSeries</_name>
				<_type>F23_CTS</_type>
				<xsl:element name="ResolutionDuration">
					<xsl:value-of select="//*[local-name()='ReportingPeriod']/*[local-name()='ResolutionDuration']" />
				</xsl:element>	   

				<_entities>
					<xsl:apply-templates />
				</_entities>
				
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="CalendarTimeSeriesValNTemplate" match="//*[local-name()='Transaction']/*[local-name()='CalendarTimeSeries']/*[local-name()='CalendarTimeSeriesValues']">
		<_entities_element>
			<entity>
				<_name>TimeSeriesValN</_name>
				<_type>F23_CTV</_type>
				<xsl:element name="Sequence">
					<xsl:value-of select="./*[local-name()='Sequence']" />
				</xsl:element>
				<xsl:element name="Value">
					<xsl:choose>
						<xsl:when test="./*[local-name()='Value']='0' or ./*[local-name()='Value']='false'">0</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</entity>
		</_entities_element>
	</xsl:template>
	<xsl:template name="PriceTimeSeriesValueTemplate" match="//*[local-name()='Transaction']/*[local-name()='PriceTimeSeries']">
		<_entities_element>
			<entity>
				<_name>PriceTimeSeries</_name>
				<_type>F23_PTS</_type>
				<xsl:element name="ResolutionDuration">
					<xsl:value-of select="//*[local-name()='PriceReportingPeriod']/*[local-name()='ResolutionDuration']" />
				</xsl:element>	   
				
				<_entities>
					<xsl:apply-templates />
				</_entities>
				
			</entity>
		</_entities_element>
	</xsl:template>

	<xsl:template name="PriceTimeSeriesValNTemplate" match="//*[local-name()='PriceTimeSeries']/*[local-name()='PriceTimeSeriesValues']">
		<_entities_element>
			<entity>
				<_name>TimeSeriesValN</_name>
				<_type>F23_PTV</_type>
				<xsl:element name="Sequence">
					<xsl:value-of select="./*[local-name()='Sequence']" />
				</xsl:element>
				<xsl:element name="Price">
					<xsl:value-of select="./*[local-name()='Price']" />
				</xsl:element>
				<xsl:element name="PriceWithTax">
					<xsl:value-of select="./*[local-name()='PriceWithTax']" />
				</xsl:element>
			</entity>
		</_entities_element>
	</xsl:template>

</xsl:stylesheet>