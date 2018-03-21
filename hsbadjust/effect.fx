/////////////////////////////////////////////////////////
// Adjust HSB effect
// Original Construct 2 effect by Somebody
// Ported to Construct 3 by Jeremy Lonien aka Ludonaut
/////////////////////////////////////////////////////////

varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;
precision mediump float;
uniform float huerotate;
uniform float satadjust;
uniform float briadjust;

// conversion functions by Sam Hocevar
// https://gamedev.stackexchange.com/a/59808
vec3 rgb_to_hsl(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsl_to_rgb(vec3 c)
{	
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void)
{
	// Retrieve front and back pixels
	vec4 front = texture2D(samplerFront, vTex);
	vec3 rgb = rgb_to_hsl(front.rgb) + vec3(huerotate, 0, (briadjust - 1.0) * front.a);
	rgb.y *= satadjust;
	rgb = hsl_to_rgb(rgb);
	gl_FragColor = vec4(rgb, front.a);
}
