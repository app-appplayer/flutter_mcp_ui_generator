# Flutter MCP UI Generator Examples

이 폴더에는 Flutter MCP UI Generator의 다양한 사용 예제들이 포함되어 있습니다.

## 📁 예제 구조

### 1. 기본 위젯 예제 (Basic Widgets)
- `01_basic_widgets/` - 모든 기본 위젯들의 사용법 데모
  - `widgets_showcase.dart` - 레이아웃, 디스플레이, 입력 위젯 쇼케이스
  - `styling_examples.dart` - 텍스트 스타일, 데코레이션, 테마 예제

### 2. 폼과 입력 예제 (Forms & Input)
- `02_forms_input/` - 폼 구성과 입력 위젯 활용
  - `login_form.dart` - 로그인 폼 예제
  - `user_profile_form.dart` - 사용자 프로필 편집 폼
  - `dynamic_form.dart` - 동적 폼 생성 예제

### 3. 네비게이션 예제 (Navigation)
- `03_navigation/` - 페이지 라우팅과 네비게이션
  - `multi_page_app.dart` - 멀티 페이지 앱 구조
  - `bottom_navigation.dart` - 하단 네비게이션 예제
  - `drawer_navigation.dart` - 드로어 네비게이션 예제

### 4. 상태 관리 예제 (State Management)
- `04_state_management/` - 상태 관리와 데이터 바인딩
  - `counter_app.dart` - 간단한 카운터 앱
  - `todo_list.dart` - 할일 목록 앱
  - `shopping_cart.dart` - 쇼핑카트 상태 관리

### 5. 실제 애플리케이션 예제 (Real-world Apps)
- `05_real_world/` - 실제 사용 시나리오
  - `weather_app/` - 날씨 앱 예제
  - `e_commerce/` - 이커머스 앱 예제
  - `dashboard/` - 대시보드 UI 예제

### 6. 통합 예제 (Integration Examples)
- `06_integration/` - MCP 서버와 통합
  - `mcp_server_demo.dart` - MCP 서버 연동 데모
  - `tool_integration.dart` - 도구 호출 예제
  - `resource_subscription.dart` - 리소스 구독 예제

## 🚀 예제 실행 방법

각 예제는 독립적으로 실행 가능한 Dart 파일로 구성되어 있습니다:

```bash
# JSON 생성 예제 실행
dart run example/01_basic_widgets/widgets_showcase.dart

# 생성된 JSON 파일 확인
cat widgets_showcase.json
```

## 📝 예제 활용 팁

1. **학습 순서**: 01번부터 순차적으로 학습하시는 것을 권장합니다
2. **JSON 출력**: 각 예제는 해당하는 JSON 파일을 생성합니다
3. **코드 수정**: 예제 코드를 수정하며 다양한 옵션을 실험해보세요
4. **실제 적용**: 생성된 JSON을 MCP UI Runtime에서 테스트해보세요

## 🔧 개발자 가이드

새로운 예제를 추가할 때:
1. 적절한 카테고리 폴더에 배치
2. 명확한 주석과 설명 추가
3. JSON 출력 파일명을 예제명과 일치시키기
4. README.md 업데이트

## 📚 추가 자료

- [MCP UI DSL v1.0 스펙](https://github.com/modelcontextprotocol/typescript-sdk)
- [Flutter MCP UI Runtime](https://github.com/flutter-mcp-ui/runtime)
- [MCP 서버 개발 가이드](https://docs.anthropic.com/mcp)