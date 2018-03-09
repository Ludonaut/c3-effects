////////////////////////////////////////////////////////////////////////////
// RGBA-channel separation
// Many thanks to David Clark who wrote this shader for Construct Classic
// Original Construct 2 effect 'RGBA channel separation' by Jan Raap a.k.a. oppenheimer
// Ported to Construct 3 by Jeremy Lonien aka Ludonaut
////////////////////////////////////////////////////////////////////////////

precision lowp float;

varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

// uniform float pixelWidth;
// uniform float pixelHeight;
// these were used in C2 and replaced by pixelSize in C3.

// available uniforms in C3:
uniform mediump vec2 srcStart; // current foreground rectangle, clamped
uniform mediump vec2 srcEnd;
uniform mediump vec2 srcOriginStart; // same as above but unclamped
uniform mediump vec2 srcOriginEnd;
uniform mediump vec2 layoutStart; // fg tex in layout coordinates
uniform mediump vec2 layoutEnd;
uniform lowp sampler2D samplerBackground; // bg texture sampler used for bg blending
uniform mediump vec2 destStart; // current bg rectangle in texture coordinates
uniform mediump vec2 destEnd;
uniform mediump float seconds; // used for animated effects
uniform mediump vec2 pixelSize; // size of a texel in fg texture coordinates
uniform mediump float layerScale; // layer scale as a factor (1 is unscaled)
uniform mediump float layerAngle;  // current layer angle in radians

// our effect parameters
uniform float redx;
uniform float redy;
uniform float bluex;
uniform float bluey;
uniform float greenx;
uniform float greeny;
uniform float alphax;
uniform float alphay;
uniform float intensity;

void main(void)
{
	vec4 front = texture2D(samplerFront, vTex); 
	vec4 color = texture2D(samplerFront, vTex); 
	
	// the way it was done in C2
	// color.r = texture2D(samplerFront, vTex - vec2(redx   * pixelWidth, redy   * pixelHeight)).r;
	// color.g = texture2D(samplerFront, vTex - vec2(greenx * pixelWidth, greeny * pixelHeight)).g;
	// color.b = texture2D(samplerFront, vTex - vec2(bluex  * pixelWidth, bluey  * pixelHeight)).b;
	// color.a = texture2D(samplerFront, vTex - vec2(alphax * pixelWidth, alphay * pixelHeight)).a;

	// this works but has scaling issues. (offset increases the smaller the game window gets)
	color.r = texture2D(samplerFront, vTex - vec2(redx   * pixelSize.x, redy   * pixelSize.y)).r;
	color.g = texture2D(samplerFront, vTex - vec2(greenx * pixelSize.x, greeny * pixelSize.y)).g;
	color.b = texture2D(samplerFront, vTex - vec2(bluex  * pixelSize.x, bluey  * pixelSize.y)).b;
	color.a = texture2D(samplerFront, vTex - vec2(alphax * pixelSize.x, alphay * pixelSize.y)).a;
	
	gl_FragColor = mix(front, color, intensity);
}