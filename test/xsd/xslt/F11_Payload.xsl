<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
	<xsl:template name="ProductTemplate" match="//*[local-name()='Transaction']">
		<_name>Product</_name>
		<_type>F11_PRD</_type>
		<xsl:element name="ProductCode">
			<xsl:value-of select="./*[local-name()='ProductIdentification']" />
		</xsl:element>
		<xsl:if test="./*[local-name()='ProductDescription']">
			<xsl:element name="ProductDescription">
				<xsl:value-of select="./*[local-name()='ProductDescription']" />
			</xsl:element>
		</xsl:if>

		<!-- For each language loaded inLanguage specific attributes -->	   
		<xsl:for-each select="//*[local-name()='ProductNames']">

			<xsl:if test="./*[local-name()='Language'] ='fi'">	   
				<xsl:element name="ProductNameLanguageFI">
					<xsl:value-of select="./*[local-name()='Language']" />
				</xsl:element>
				<xsl:element name="ProductNameFI">
					<xsl:value-of select="./*[local-name()='ProductName']" />
				</xsl:element>
			</xsl:if>		   

			<xsl:if test="./*[local-name()='Language'] ='sv'">	   
				<xsl:element name="ProductNameLanguageSV">
					<xsl:value-of select="./*[local-name()='Language']" />
				</xsl:element>
				<xsl:element name="ProductNameSV">
					<xsl:value-of select="./*[local-name()='ProductName']" />
				</xsl:element>
			</xsl:if>		   

			<xsl:if test="./*[local-name()='Language'] ='en'">	   
				<xsl:element name="ProductNameLanguageEN">
					<xsl:value-of select="./*[local-name()='Language']" />
				</xsl:element>
				<xsl:element name="ProductNameEN">
					<xsl:value-of select="./*[local-name()='ProductName']" />
				</xsl:element>
			</xsl:if>		   

		</xsl:for-each>

		<_entities>
			<xsl:apply-templates />
		</_entities>
	</xsl:template>
	<xsl:template name="ProductComponentTemplate" match="//*[local-name()='ProductComponents']">
		<_entities_element>
			<entity>
				<_name>ProductComponent</_name>
				<_type>F11_PCP</_type>
				<xsl:element name="ProductComponentCode">
					<xsl:value-of select="./*[local-name()='ProductComponentIdentification']" />
				</xsl:element>
				<xsl:element name="PriceInformationType">
					<xsl:value-of select="./*[local-name()='PriceInformationType']" />
				</xsl:element>
				<xsl:element name="PriceUnitIdentification">
					<xsl:value-of select="./*[local-name()='PriceUnitCode']" />
				</xsl:element>
				<xsl:if test="./*[local-name()='TaxRate']">
					<xsl:element name="TaxRate">
						<xsl:value-of select="./*[local-name()='TaxRate']" />
					</xsl:element>
				</xsl:if>

				<!-- For each language loaded inLanguage specific attributes -->	   	   
				<xsl:for-each select="./*[local-name()='ProductComponentInformation']">

					<xsl:if test="./*[local-name()='Language'] ='fi'">	   
						<xsl:element name="ProductComponentDataLanguageFI">
							<xsl:value-of select="./*[local-name()='Language']" />
						</xsl:element>
						<xsl:element name="ProductComponentNameFI">
							<xsl:value-of select="./*[local-name()='ProductComponentName']" />
						</xsl:element>
						<xsl:element name="PriceUnitFI">
							<xsl:value-of select="./*[local-name()='PriceUnit']" />
						</xsl:element>		   
					</xsl:if>		   

					<xsl:if test="./*[local-name()='Language'] ='sv'">	   
						<xsl:element name="ProductComponentDataLanguageSV">
							<xsl:value-of select="./*[local-name()='Language']" />
						</xsl:element>
						<xsl:element name="ProductComponentNameSV">
							<xsl:value-of select="./*[local-name()='ProductComponentName']" />
						</xsl:element>
						<xsl:element name="PriceUnitSV">
							<xsl:value-of select="./*[local-name()='PriceUnit']" />
						</xsl:element>		   
					</xsl:if>		   

					<xsl:if test="./*[local-name()='Language'] ='en'">	   
						<xsl:element name="ProductComponentDataLanguageEN">
							<xsl:value-of select="./*[local-name()='Language']" />
						</xsl:element>
						<xsl:element name="ProductComponentNameEN">
							<xsl:value-of select="./*[local-name()='ProductComponentName']" />
						</xsl:element>
						<xsl:element name="PriceUnitEN">
							<xsl:value-of select="./*[local-name()='PriceUnit']" />
						</xsl:element>		   
					</xsl:if>

				</xsl:for-each>






				<_entities>
					<xsl:apply-templates />
				</_entities>
			</entity>
		</_entities_element>
	</xsl:template>
</xsl:stylesheet>