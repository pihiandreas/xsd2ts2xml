<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:urn="urn:cms:b2b:v01">
	<xsl:import href="F18_OutboundPayload.xsl" />
	<xsl:output omit-xml-declaration="yes" indent="no" method="xml"
		encoding="UTF-8" />
	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
			<soapenv:Header />
			<soapenv:Body>
				<urn:PeekMessageResponse>
					<urn:MessageContainer>
						<xsl:if test="./*/ExternalMessageID">
							<urn:DocumentReferenceNumber>
								<xsl:value-of select="./*/ExternalMessageID" />
							</urn:DocumentReferenceNumber>
						</xsl:if>
						<urn:Payload>
							<xsl:apply-imports/>
						</urn:Payload>
					</urn:MessageContainer>
				</urn:PeekMessageResponse>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
</xsl:stylesheet>