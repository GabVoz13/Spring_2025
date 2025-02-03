<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" doctype-public="-//W3C//DTD SVG 1.1//EN" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" indent="yes"/>
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="800" height="600">
            <rect width="800" height="600" fill="white"/>
            
            <line x1="50" y1="550" x2="750" y2="550" stroke="black" stroke-width="2"/>
            <line x1="50" y1="550" x2="50" y2="50" stroke="black" stroke-width="2"/>
            
            <xsl:for-each select="xml/page/panel">
                <xsl:variable name="x" select="50 + (position() * 100)"/>
                <xsl:variable name="y" select="550 - (number(@order) * 80)"/>
                
                <xsl:variable name="size" select="40 + (number(@order) * 10)"/>
                
                <xsl:variable name="color">
                    <xsl:choose>
                        <xsl:when test="position() mod 2 = 0">blue</xsl:when>
                        <xsl:otherwise>red</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:choose>
                    <xsl:when test="@shape='box'">
                        <rect x="{$x}" y="{$y}" width="{$size}" height="{$size}" fill="{$color}" stroke="black"/>
                    </xsl:when>
                    <xsl:when test="@shape='wavy-center'">
                        <circle cx="{$x}" cy="{$y}" r="{$size div 2}" fill="{$color}" stroke="black"/>
                    </xsl:when>
                </xsl:choose>
                
                <text x="{$x}" y="{$y - 10}" font-size="12" fill="black" text-anchor="middle">
                    <xsl:value-of select="@order"/>
                </text>
            </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>
