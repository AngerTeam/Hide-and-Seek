Shader "kaleb/Voxel Shader" {
Properties {
 _MainTex ("Main Texture", 2D) = "white" { }
 _MainColor ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _SkyLight ("Sky Light", Color) = (1.000000,1.000000,1.000000,0.000000)
 _AmbientLight ("Ambient Light Color", Color) = (0.200000,0.200000,0.200000,0.000000)
 _NormalPower ("Normal Power", Range(0.000000,1.000000)) = 0.200000
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  GpuProgramID 63013
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _NormalPower;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp float power_2;
					  lowp vec4 lit_3;
					  lit_3 = tmpvar_1;
					  highp float tmpvar_4;
					  tmpvar_4 = min ((lit_3.x + (_SkyLight.x * lit_3.w)), 1.0);
					  lit_3.x = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = min ((lit_3.y + (_SkyLight.y * lit_3.w)), 1.0);
					  lit_3.y = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = min ((lit_3.z + (_SkyLight.z * lit_3.w)), 1.0);
					  lit_3.z = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (lit_3.x, _AmbientLight.x);
					  lit_3.x = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_3.y, _AmbientLight.y);
					  lit_3.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_3.z, _AmbientLight.z);
					  lit_3.z = tmpvar_9;
					  power_2 = ((_glesNormal.y + 1.0) / 2.0);
					  power_2 = (1.0 + ((power_2 - 1.0) * _NormalPower));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = (lit_3 * power_2);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 * xlv_COLOR);
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _NormalPower;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp float power_2;
					  lowp vec4 lit_3;
					  lit_3 = tmpvar_1;
					  highp float tmpvar_4;
					  tmpvar_4 = min ((lit_3.x + (_SkyLight.x * lit_3.w)), 1.0);
					  lit_3.x = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = min ((lit_3.y + (_SkyLight.y * lit_3.w)), 1.0);
					  lit_3.y = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = min ((lit_3.z + (_SkyLight.z * lit_3.w)), 1.0);
					  lit_3.z = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (lit_3.x, _AmbientLight.x);
					  lit_3.x = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_3.y, _AmbientLight.y);
					  lit_3.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_3.z, _AmbientLight.z);
					  lit_3.z = tmpvar_9;
					  power_2 = ((_glesNormal.y + 1.0) / 2.0);
					  power_2 = (1.0 + ((power_2 - 1.0) * _NormalPower));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = (lit_3 * power_2);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 * xlv_COLOR);
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _NormalPower;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp float power_2;
					  lowp vec4 lit_3;
					  lit_3 = tmpvar_1;
					  highp float tmpvar_4;
					  tmpvar_4 = min ((lit_3.x + (_SkyLight.x * lit_3.w)), 1.0);
					  lit_3.x = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = min ((lit_3.y + (_SkyLight.y * lit_3.w)), 1.0);
					  lit_3.y = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = min ((lit_3.z + (_SkyLight.z * lit_3.w)), 1.0);
					  lit_3.z = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (lit_3.x, _AmbientLight.x);
					  lit_3.x = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_3.y, _AmbientLight.y);
					  lit_3.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_3.z, _AmbientLight.z);
					  lit_3.z = tmpvar_9;
					  power_2 = ((_glesNormal.y + 1.0) / 2.0);
					  power_2 = (1.0 + ((power_2 - 1.0) * _NormalPower));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_COLOR = (lit_3 * power_2);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 * xlv_COLOR);
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _NormalPower;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec4 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xyz = _SkyLight.xyz * in_COLOR0.www + in_COLOR0.xyz;
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat1 = in_NORMAL0.y + 1.0;
					    u_xlat1 = u_xlat1 * 0.5 + -1.0;
					    u_xlat1 = u_xlat1 * _NormalPower + 1.0;
					    u_xlat0.w = in_COLOR0.w;
					    vs_COLOR0 = u_xlat0 * vec4(u_xlat1);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0 * vs_COLOR0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _NormalPower;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec4 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xyz = _SkyLight.xyz * in_COLOR0.www + in_COLOR0.xyz;
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat1 = in_NORMAL0.y + 1.0;
					    u_xlat1 = u_xlat1 * 0.5 + -1.0;
					    u_xlat1 = u_xlat1 * _NormalPower + 1.0;
					    u_xlat0.w = in_COLOR0.w;
					    vs_COLOR0 = u_xlat0 * vec4(u_xlat1);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0 * vs_COLOR0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _NormalPower;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec4 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.xyz = _SkyLight.xyz * in_COLOR0.www + in_COLOR0.xyz;
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(1.0, 1.0, 1.0));
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat1 = in_NORMAL0.y + 1.0;
					    u_xlat1 = u_xlat1 * 0.5 + -1.0;
					    u_xlat1 = u_xlat1 * _NormalPower + 1.0;
					    u_xlat0.w = in_COLOR0.w;
					    vs_COLOR0 = u_xlat0 * vec4(u_xlat1);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0 * vs_COLOR0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {

}
SubProgram "gles hw_tier02 " {

}
SubProgram "gles hw_tier03 " {

}
SubProgram "gles3 hw_tier01 " {

}
SubProgram "gles3 hw_tier02 " {

}
SubProgram "gles3 hw_tier03 " {

}
}
 }
}
}