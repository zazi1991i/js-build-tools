<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output
		method="html"
		indent="yes"
		omit-xml-declaration="yes"
		doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
		doctype-public="-//W3C//DTD XHTML 1.1//EN"
	/>

	<xsl:param name="target" />

	<xsl:template match="/">
		<html>
		<head>
			<title>Class</title>
			<link href="css/general.css" rel="stylesheet" type="text/css" />
		</head>
		<body>
			<div class="classDetailsContent">
				<h1><xsl:value-of select="//class[@fullname=$target]/@fullname" /></h1>

				<xsl:call-template name="class_details" />

				<div class="classDescription">
					<xsl:value-of select="//class[@fullname=$target]/description/text()" />
				</div>

				<div class="summaryLists">
					<!-- Property summary -->
					<xsl:call-template name="member_summary_list">
						<xsl:with-param	name="type">property</xsl:with-param>
						<xsl:with-param	name="singular">Property</xsl:with-param>
						<xsl:with-param	name="plural">Properties</xsl:with-param>
					</xsl:call-template>

					<!-- Method summary -->
					<xsl:call-template name="member_summary_list">
						<xsl:with-param	name="type">method</xsl:with-param>
						<xsl:with-param	name="singular">Method</xsl:with-param>
						<xsl:with-param	name="plural">Methods</xsl:with-param>
					</xsl:call-template>

					<!-- Event summary -->
					<xsl:call-template name="member_summary_list">
						<xsl:with-param	name="type">event</xsl:with-param>
						<xsl:with-param	name="singular">Event</xsl:with-param>
						<xsl:with-param	name="plural">Events</xsl:with-param>
					</xsl:call-template>
				</div>

				<div class="details">
					<!-- Property details -->
					<xsl:call-template name="member_details_list">
						<xsl:with-param	name="type">property</xsl:with-param>
						<xsl:with-param	name="singular">Property</xsl:with-param>
						<xsl:with-param	name="plural">Properties</xsl:with-param>
					</xsl:call-template>

					<!-- Method details -->
					<xsl:call-template name="member_details_list">
						<xsl:with-param	name="type">method</xsl:with-param>
						<xsl:with-param	name="singular">Method</xsl:with-param>
						<xsl:with-param	name="plural">Methods</xsl:with-param>
					</xsl:call-template>

					<!-- Event details -->
					<xsl:call-template name="member_details_list">
						<xsl:with-param	name="type">event</xsl:with-param>
						<xsl:with-param	name="singular">Event</xsl:with-param>
						<xsl:with-param	name="plural">Events</xsl:with-param>
					</xsl:call-template>
				</div>
			</div>
		</body>
		</html>
	</xsl:template>

	<xsl:template name="class_details">
		<table class="classDetails">
			<xsl:if test="//class[@fullname=$target]/parent::namespace">
				<tr>
					<td class="first">Namespace</td>
					<td class="last"><xsl:value-of select="//class[@fullname=$target]/parent::*/@fullname" /></td>
				</tr>
			</xsl:if>

			<tr>
				<td class="first">Class</td>
				<td class="last"><xsl:value-of select="//class[@fullname=$target]/@name" /></td>
			</tr>

			<xsl:if test="//class[@fullname=$target]/super-classes/class-ref">
				<tr>
					<td class="first">Inheritance</td>
					<td class="last inheritageList">
						<span><xsl:value-of select="//class[@fullname=$target]/@name" /></span>

						<xsl:for-each select="//class[@fullname=$target]/super-classes/class-ref">
							<span>
								<xsl:if test="position() = last()">
									<xsl:attribute name="class">last</xsl:attribute>
								</xsl:if>

								<a>
									<xsl:attribute name="href">class_<xsl:value-of select="@class" />.html</xsl:attribute>

									<xsl:variable name="class" select="@class" />
									<xsl:value-of select="//class[@fullname=$class]/@name" />
								</a>
							</span>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>

			<xsl:if test="//class[@alias-for=$target]">
				<tr>
					<td class="first">Aliases</td>
					<td class="last aliasesList">
						<xsl:for-each select="//class[@alias-for=$target]">
							<xsl:value-of select="@fullname" />
							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>

			<xsl:if test="//class[@extends=$target]">
				<tr>
					<td class="first">Subclasses</td>
					<td class="last subClassList">
						<xsl:for-each select="//class[@extends=$target]">
							<a>
								<xsl:attribute name="href">class_<xsl:value-of select="@fullname" />.html</xsl:attribute>
								<xsl:value-of select="@name" />
							</a>

							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template name="member_summary_list">
		<xsl:param name="type" />
		<xsl:param name="singular" />
		<xsl:param name="plural" />

		<xsl:if test="//class[@fullname=$target]/members/*[name()=$type]">
			<h2>Public <xsl:value-of select="$plural" /></h2>

			<table>
				<xsl:attribute name="class"><xsl:value-of select="$plural" /> summary</xsl:attribute>

				<thead>
					<tr>
						<th><xsl:value-of select="$singular" /></th>
						<th>Defined By</th>
					</tr>
				</thead>

				<tbody>
					<xsl:for-each select="//class[@fullname=$target]/members/*[name()=$type]">
						<xsl:sort select="@constructor" order="descending" />
						<xsl:sort select="@name" />

						<tr>
							<xsl:choose>
								<xsl:when test="position() mod 2 = 0 and @inherited-from">
									<xsl:attribute name="class">inherited even</xsl:attribute>
								</xsl:when>

								<xsl:when test="@inherited-from">
									<xsl:attribute name="class">inherited</xsl:attribute>
								</xsl:when>

								<xsl:when test="position() mod 2 = 0">
									<xsl:attribute name="class">even</xsl:attribute>
								</xsl:when>
							</xsl:choose>

							<td class="first">
								<xsl:choose>
									<xsl:when test="@inherited-from">
										<xsl:variable name="inherited-from"><xsl:value-of select="@inherited-from" /></xsl:variable>
										<xsl:variable name="name"><xsl:value-of select="@name" /></xsl:variable>

										<xsl:for-each select="//class[@fullname=$inherited-from]/members/*[@name=$name]">
											<xsl:call-template name="member_summary" />
										</xsl:for-each>
									</xsl:when>

									<xsl:otherwise>
										<xsl:call-template name="member_summary" />
									</xsl:otherwise>
								</xsl:choose>
							</td>

							<td class="last">
								<xsl:choose>
									<xsl:when test="@inherited-from">
										<xsl:variable name="inherited-from"><xsl:value-of select="@inherited-from" /></xsl:variable>

										<xsl:call-template name="type_name">
											<xsl:with-param	name="type">
												<xsl:value-of select="//class[@fullname=$inherited-from]/@fullname" />
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>

									<xsl:otherwise>
										<xsl:value-of select="//class[@fullname=$target]/@name" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="member_details_list">
		<xsl:param name="type" />
		<xsl:param name="singular" />
		<xsl:param name="plural" />

		<xsl:if test="//class[@fullname=$target]/members/*[name()=$type]">
			<h1><xsl:value-of select="$singular" /> details</h1>

			<xsl:for-each select="//class[@fullname=$target]/members/*[name()=$type][not(@inherited-from)]">
				<xsl:sort select="@constructor" order="descending" />
				<xsl:sort select="@name" />

				<xsl:call-template name="member_details" />
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="member_summary">
		<div>
			<a>
				<xsl:attribute name="href">class_<xsl:value-of select="parent::members/parent::class/@fullname" />.html#<xsl:value-of select="@name" /></xsl:attribute>
				<xsl:value-of select="@name" />
			</a>

			<xsl:choose>
				<xsl:when test="name() = 'method'">
					<xsl:text>(</xsl:text>
					<xsl:for-each select="param">
						<xsl:value-of select="@name" />
						<xsl:text>:</xsl:text>
						<xsl:call-template name="type_name">
							<xsl:with-param	name="type"><xsl:value-of select="@type" /></xsl:with-param>
						</xsl:call-template>

						<xsl:if test="position() != last()">, </xsl:if>
					</xsl:for-each>
					<xsl:text>)</xsl:text>

					<!-- Output return type -->
					<xsl:if test="not(@constructor)">
						<xsl:text>:</xsl:text>
						<xsl:choose>
							<xsl:when test="return">
								<xsl:call-template name="type_name">
									<xsl:with-param	name="type"><xsl:value-of select="return/@type" /></xsl:with-param>
								</xsl:call-template>
							</xsl:when>

							<xsl:otherwise>void</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:when>

				<xsl:when test="name() = 'property'">
					<!-- Output type -->
					<xsl:text> : </xsl:text>
					<xsl:choose>
						<xsl:when test="@type">
							<xsl:call-template name="type_name">
								<xsl:with-param	name="type"><xsl:value-of select="@type" /></xsl:with-param>
							</xsl:call-template>
						</xsl:when>

						<xsl:otherwise>Object</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</div>

		<div class="summary">
			<xsl:if test="@static">[static] </xsl:if>
			<xsl:text><xsl:value-of select="@summary" /></xsl:text>
		</div>
	</xsl:template>

	<xsl:template name="member_details">
		<div class="memberDetails">
			<xsl:attribute name="id"><xsl:value-of select="@name" /></xsl:attribute>

			<h2>
				<xsl:value-of select="@name" />

				<span class="memberType">
					<xsl:choose>
						<xsl:when test="@constructor">constructor</xsl:when>
						<xsl:otherwise><xsl:value-of select="name()" /></xsl:otherwise>
					</xsl:choose>
				</span>
			</h2>

			<code>
				<xsl:choose>
					<xsl:when test="@protected">protected </xsl:when>
					<xsl:when test="@private">private </xsl:when>
					<xsl:otherwise>public </xsl:otherwise>
				</xsl:choose>

				<xsl:if test="@static">static </xsl:if>

				<xsl:choose>
					<xsl:when test="name() = 'method'">
						function <xsl:value-of select="@name" />

						<xsl:text>(</xsl:text>
						<xsl:for-each select="param">
							<xsl:value-of select="@name" />
							<xsl:text>:</xsl:text>
							<xsl:call-template name="type_name">
								<xsl:with-param	name="type"><xsl:value-of select="@type" /></xsl:with-param>
							</xsl:call-template>

							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
						<xsl:text>)</xsl:text>

						<!-- Output return type -->
						<xsl:if test="not(@constructor)">
							<xsl:text>:</xsl:text>
							<xsl:choose>
								<xsl:when test="return">
									<xsl:call-template name="type_name">
										<xsl:with-param	name="type"><xsl:value-of select="return/@type" /></xsl:with-param>
									</xsl:call-template>
								</xsl:when>

								<xsl:otherwise>void</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:when>

					<xsl:when test="name() = 'property'">
						<xsl:value-of select="@name" />

						<!-- Output type -->
						<xsl:text> : </xsl:text>
						<xsl:choose>
							<xsl:when test="@type">
								<xsl:call-template name="type_name">
									<xsl:with-param	name="type"><xsl:value-of select="@type" /></xsl:with-param>
								</xsl:call-template>
							</xsl:when>

							<xsl:otherwise>Object</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:otherwise><xsl:value-of select="@name" /></xsl:otherwise>
				</xsl:choose>
			</code>

			<div class="memberDescription"><xsl:value-of select="description/text()" disable-output-escaping="yes" /></div>

			<!-- Output parameters -->
			<xsl:if test="param">
				<h3>Parameters</h3>

				<table class="params">
					<xsl:for-each select="param">
						<tr>
							<td class="first">
								<xsl:value-of select="@name" />
								<xsl:text>:</xsl:text>
								<xsl:call-template name="type_name">
									<xsl:with-param	name="type"><xsl:value-of select="@type" /></xsl:with-param>
								</xsl:call-template>
							</td>
							<td class="last"><xsl:value-of select="description/text()" /></td>
						</tr>
					</xsl:for-each>
				</table>
			</xsl:if>

			<!-- Output return -->
			<xsl:if test="return">
				<h3>Returns</h3>
				<div class="return">
					<xsl:call-template name="type_name">
						<xsl:with-param	name="type"><xsl:value-of select="return/@type" /></xsl:with-param>
					</xsl:call-template>

					<xsl:text> - <xsl:value-of select="return/description/text()" /></xsl:text>
				</div>
			</xsl:if>

			<!-- Output see also -->
			<xsl:if test="see">
				<h3>See Also</h3>

				<ul>
					<xsl:for-each select="see">
						<xsl:variable name="class" select="@class" />
						<xsl:variable name="member" select="@member" />

						<li>
							<a>
								<xsl:attribute name="href">
									<xsl:if test="@class">class_<xsl:value-of select="@class" />.html</xsl:if>
									<xsl:if test="@member">#<xsl:value-of select="@member" /></xsl:if>
								</xsl:attribute>

								<xsl:text><xsl:value-of select="//class[@fullname=$class]/@name" /></xsl:text>

								<xsl:if test="@member">
									<xsl:if test="@class">.</xsl:if>

									<xsl:choose>
										<xsl:when test="//class[@fullname=$class]/members/method[@name=$member]">
											<xsl:text><xsl:value-of select="$member" />()</xsl:text>
										</xsl:when>

										<xsl:otherwise>
											<xsl:value-of select="$member" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</a>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:if>

			<!-- Output examples -->
			<xsl:if test="example">
				<xsl:for-each select="example">
					<h3>Example</h3>
					<pre>
						<xsl:value-of select="example/text()" disable-output-escaping="yes" />
					</pre>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template name="type_name">
		<xsl:param name="type" />

		<xsl:choose>
			<xsl:when test="//class[@fullname=$type]">
				<a>
					<xsl:attribute name="href">class_<xsl:value-of select="$type" />.html</xsl:attribute>
					<xsl:value-of select="//class[@fullname=$type]/@name" />
				</a>
			</xsl:when>

			<xsl:otherwise><xsl:value-of select="$type" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>