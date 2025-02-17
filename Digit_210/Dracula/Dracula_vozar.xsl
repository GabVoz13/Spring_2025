<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <document>
            <xsl:apply-templates/>
        </document>
    </xsl:template>
    
    <!-- Apply transformations in sequence -->
    <xsl:template match="text()">
        <xsl:variable name="step1">
            <xsl:apply-templates select="." mode="tag_dates"/>
        </xsl:variable>
        <xsl:variable name="step2">
            <xsl:apply-templates select="$step1" mode="tag_quotes"/>
        </xsl:variable>
        <xsl:variable name="step3">
            <xsl:apply-templates select="$step2" mode="tag_journal"/>
        </xsl:variable>
        <xsl:apply-templates select="$step3" mode="tag_letters"/>
    </xsl:template>
    
    <!-- Tag Dates -->
    <xsl:template match="text()" mode="tag_dates">
        <xsl:analyze-string select="." regex="\b(\d{{1,2}} [A-Za-z]+)\b">
            <xsl:matching-substring>
                <date><xsl:value-of select="."/></date>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <!-- Tag Quotes -->
    <xsl:template match="text()" mode="tag_quotes">
        <xsl:analyze-string select="." regex='"([^"]+)"'>
            <xsl:matching-substring>
                <quote><xsl:value-of select="regex-group(1)"/></quote>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <!-- Tag Journal Titles -->
    <xsl:template match="text()" mode="tag_journal">
        <xsl:analyze-string select="." regex="([A-Z\s]+’S JOURNAL)">
            <xsl:matching-substring>
                <journal-title><xsl:value-of select="."/></journal-title>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <!-- Tag Letters -->
    <xsl:template match="text()" mode="tag_letters">
        <xsl:analyze-string select="." regex="My Friend.—(.*?)\n">
            <xsl:matching-substring>
                <letter>
                    <body><xsl:value-of select="regex-group(1)"/></body>
                </letter>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
</xsl:stylesheet>