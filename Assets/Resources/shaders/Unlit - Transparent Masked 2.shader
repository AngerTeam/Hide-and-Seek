Shader "Hidden/Unlit/Transparent Masked 2" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" { }
 _Mask ("Alpha (A)", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  Offset -1.000000, -1.000000
  GpuProgramID 5154
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
					  xlv_TEXCOORD2 = tmpvar_1;
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _Mask;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.zw)) * _ClipArgs1.xy);
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
					  col_1 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_Mask, xlv_TEXCOORD1);
					  col_1.w = (col_1.w * tmpvar_6.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
					  xlv_TEXCOORD2 = tmpvar_1;
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _Mask;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.zw)) * _ClipArgs1.xy);
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
					  col_1 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_Mask, xlv_TEXCOORD1);
					  col_1.w = (col_1.w * tmpvar_6.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _ClipRange0;
					uniform highp vec4 _ClipRange1;
					uniform highp vec4 _ClipArgs1;
					highp vec4 tmpvar_1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
					  highp vec2 ret_2;
					  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
					  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
					  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
					  xlv_TEXCOORD2 = tmpvar_1;
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _Mask;
					uniform highp vec4 _ClipArgs0;
					uniform highp vec4 _ClipArgs1;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 col_1;
					  highp vec2 factor_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.xy)) * _ClipArgs0.xy);
					  factor_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD2.zw)) * _ClipArgs1.xy);
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
					  col_1 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (min (min (tmpvar_3.x, tmpvar_3.y), min (factor_2.x, factor_2.y)), 0.0, 1.0);
					  col_1.w = (col_1.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_Mask, xlv_TEXCOORD1);
					  col_1.w = (col_1.w * tmpvar_6.w);
					  gl_FragData[0] = col_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD2.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD2.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Mask;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					lowp float u_xlat10_2;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD2) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat10_2 = texture(_Mask, vs_TEXCOORD1.xy).w;
					    u_xlat1.w = u_xlat10_2 * u_xlat0.x;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD2.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD2.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Mask;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					lowp float u_xlat10_2;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD2) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat10_2 = texture(_Mask, vs_TEXCOORD1.xy).w;
					    u_xlat1.w = u_xlat10_2 * u_xlat0.x;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _ClipRange0;
					uniform 	vec4 _ClipRange1;
					uniform 	vec4 _ClipArgs1;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = in_POSITION0.y * _ClipArgs1.z;
					    u_xlat2.x = in_POSITION0.x * _ClipArgs1.w + (-u_xlat0.x);
					    u_xlat2.y = dot(in_POSITION0.xy, _ClipArgs1.zw);
					    vs_TEXCOORD2.zw = u_xlat2.xy * _ClipRange1.zw + _ClipRange1.xy;
					    vs_TEXCOORD2.xy = in_POSITION0.xy * _ClipRange0.zw + _ClipRange0.xy;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ClipArgs0;
					uniform 	vec4 _ClipArgs1;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Mask;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					lowp float u_xlat10_2;
					void main()
					{
					    u_xlat0 = -abs(vs_TEXCOORD2) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat0.xy * _ClipArgs0.xy;
					    u_xlat0.zw = vec2(u_xlat0.z * _ClipArgs1.x, u_xlat0.w * _ClipArgs1.y);
					    u_xlat0.xz = min(u_xlat0.yw, u_xlat0.xz);
					    u_xlat0.x = min(u_xlat0.z, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat10_2 = texture(_Mask, vs_TEXCOORD1.xy).w;
					    u_xlat1.w = u_xlat10_2 * u_xlat0.x;
					    SV_Target0 = u_xlat1;
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
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 90090
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out lowp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    vs_COLOR0 = u_xlat16_0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in lowp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
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
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out lowp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    vs_COLOR0 = u_xlat16_0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in lowp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
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
					in highp vec3 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec3 in_TEXCOORD0;
					out lowp vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = in_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    vs_COLOR0 = u_xlat16_0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in lowp vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
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