<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sp">
        <xsl:choose>
            <xsl:when test="matches(., '^\s*([A-Za-z\s-]+)\s*\[?[:]\]?')">
                <sp>
                    <xsl:analyze-string select="." regex="^\s*([A-Za-z\s-]+)\s*\[?[:]\]?\s*(.*)">
                        <xsl:matching-substring>
                            <speaker>
                                <xsl:value-of select="regex-group(1)"/>
                            </speaker>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="regex-group(2)"/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </sp>
            </xsl:when>
            
            <xsl:otherwise>
                <stage>
                    <xsl:apply-templates/>
                </stage>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
