<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI/tei:teiHeader"/>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        <div class="row">
            <div class="col">
                <h4>About the manuscript page:</h4>
                <table class="metadata">
                    <tr>
                        <th>Title</th>
                        <td><xsl:value-of select=".//tei:title"/></td>
                    </tr>
                    <tr>
                        <th>Author</th>
                        <td><xsl:value-of select=".//tei:author"/></td>
                    </tr>
                    <tr>
                        <th>Licence</th>
                        <td><xsl:value-of select=".//tei:licence"/></td>
                    </tr>
                </table>
            </div>

            <div class="col">
                <ul>
                    <li>Total number of modifications:
                        <xsl:value-of select="count(//tei:del | //tei:add)"/>
                    </li>
                    <li>Number of additions:
                        <xsl:value-of select="count(//tei:add)"/>
                    </li>
                    <li>Number of modifications by Mary:
                        <xsl:value-of select="count(//tei:del[@hand = '#MWS'] | //tei:add[@hand = '#MWS'])"/>
                    </li>
                    <li>Number of modifications by Percy:
                        <xsl:value-of select="count(//tei:del[@hand = '#PBS'] | //tei:add[@hand = '#PBS'])"/>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:text | tei:body"/>

</xsl:stylesheet>
