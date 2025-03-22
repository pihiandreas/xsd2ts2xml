<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output  method="xml" version="1.0" encoding="UTF-8"
indent="no" />
	<!--CMD-->
	<xsl:template name="CMDAcknowledgementPayloadTemplate" match="//*[local-name()='AcknowledgementDocument']" mode="CMD">
		<_name>Payload</_name>
		<_type>PLD</_type>
		<_entities>
			<_entities_element>
				<_name>AcknowledgementDocument</_name>
				<_type>ACD</_type>
				<xsl:element name="ReceivingDocumentIdentification">
					<xsl:value-of select="//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v" />
				</xsl:element>
				<_entities>
					<xsl:apply-templates mode="CMD"/>
				</_entities>
			</_entities_element>
		</_entities>
	</xsl:template>						
	<xsl:template name="ReasonTemplate" match="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']" mode="CMD">
		<_entities_element>
			<entity>
				<_name>Reason</_name>
				<_type>REA</_type>
				<xsl:if test="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']/*[local-name()='ReasonCode']">
					<xsl:element name="ReasonCode">
						<xsl:value-of select="./*[local-name()='ReasonCode']/@v" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']/*[local-name()='ReasonText']">
					<xsl:element name="ReasonText">
						<xsl:value-of select="./*[local-name()='ReasonText']/@v" />
					</xsl:element>
				</xsl:if>
			</entity>
		</_entities_element>
	</xsl:template>

	<!-- SMT -->
	<xsl:template name="SMTAcknowledgementPayloadTemplate" match="//*[local-name()='AcknowledgementDocument']" mode="SMT">
		<_name>Payload</_name>
		<_type>PAYLOAD</_type>
		<_entities>
			<_entities_element>
				<_name>TransactionPayload</_name>
				<_type>TRANSACTION_PAYLOAD</_type>
				<xsl:choose>
					<xsl:when test="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']/*[local-name()='ReasonCode']/@v='A01'">
						<AcknowledgementType>ACK</AcknowledgementType>
					</xsl:when>
					<xsl:otherwise>
						<AcknowledgementType>NAK</AcknowledgementType>
						<_entities>
							<xsl:apply-templates mode="SMT"/>
						</_entities>
					</xsl:otherwise>
				</xsl:choose>
			</_entities_element>
		</_entities>
	</xsl:template>	

	<xsl:template name="SMTMessageRejectionTemplate" match="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']" mode="SMT">
		<_entities_element>
			<entity>
				<_name>MessageRejection</_name>
				<_type>MRJ</_type>
				<xsl:if test="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']/*[local-name()='ReasonCode']">
					<xsl:element name="RejectionCode">
						<xsl:value-of select="./*[local-name()='ReasonCode']/@v" />
					</xsl:element>
				</xsl:if>
				<xsl:if test="//*[local-name()='AcknowledgementDocument']/*[local-name()='Reason']/*[local-name()='ReasonText']">
					<_entities>
						<_entities_element>
							<_name>RejectionDetails</_name>
							<_type>MRD</_type>
							<xsl:element name="RejectionDetail">
								<xsl:value-of select="./*[local-name()='ReasonText']/@v" />
							</xsl:element>
						</_entities_element>
					</_entities>
				</xsl:if>
			</entity>
		</_entities_element>
	</xsl:template>

</xsl:stylesheet>