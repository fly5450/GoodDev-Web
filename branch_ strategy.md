
<h1>📚 Git 브랜치 전략 요약</h1>

<p>Git을 사용한 협업에서 브랜치 전략은 코드 관리와 배포 프로세스의 효율성을 높이는 데 중요합니다. 아래에서는 일반적으로 사용되는 Git 브랜치 전략인 <strong>Git Flow</strong>, <strong>GitHub Flow</strong>, <strong>GitLab Flow</strong>에 대해 요약하여 설명합니다.</p>

<hr>

<h2>🔀 Git Flow</h2>

<p><img src="https://nvie.com/img/git-model@2x.png" alt="Git Flow"></p>

<h3>개요</h3>

<p>Git Flow는 Vincent Driessen이 제안한 모델로, 복잡한 프로젝트 관리에 적합한 브랜치 전략입니다.</p>

<h3>주요 브랜치</h3>

<ul>
    <li><strong>main(master)</strong>: 배포 가능한 상태의 코드를 유지하는 브랜치입니다.</li>
    <li><strong>develop</strong>: 다음 배포를 위해 개발 중인 코드를 유지하는 브랜치입니다.</li>
</ul>

<h3>보조 브랜치</h3>

<ul>
    <li><strong>feature/</strong>: 새로운 기능을 개발하기 위한 브랜치입니다.</li>
    <li><strong>release/</strong>: 배포 준비를 위한 브랜치입니다.</li>
    <li><strong>hotfix/</strong>: 배포된 코드에서 발생한 긴급한 버그를 수정하기 위한 브랜치입니다.</li>
</ul>

<h3>흐름</h3>

<ol>
    <li><strong>기능 개발</strong>: <code>develop</code> 브랜치에서 <code>feature/</code> 브랜치를 생성하여 작업합니다.</li>
    <li><strong>기능 병합</strong>: 작업이 완료되면 <code>develop</code> 브랜치로 병합합니다.</li>
    <li><strong>배포 준비</strong>: 배포가 필요할 때 <code>develop</code> 브랜치에서 <code>release/</code> 브랜치를 생성합니다.</li>
    <li><strong>배포</strong>: <code>release/</code> 브랜치를 <code>main</code> 브랜치로 병합하고 태그를 생성합니다.</li>
    <li><strong>핫픽스</strong>: 긴급한 버그 수정이 필요하면 <code>main</code> 브랜치에서 <code>hotfix/</code> 브랜치를 생성하여 수정 후 <code>main</code>과 <code>develop</code> 브랜치로 병합합니다.</li>
</ol>

<hr>

<h2>🌐 GitHub Flow</h2>

<h3>개요</h3>

<p>GitHub Flow는 단순하고 효율적인 브랜치 전략으로, 지속적인 배포(CD)에 적합합니다.</p>

<h3>주요 특징</h3>

<ul>
    <li><strong>main(master)</strong> 브랜치 하나만을 사용하여 배포 가능한 코드를 유지합니다.</li>
    <li>모든 변경 사항은 <strong>feature 브랜치</strong>에서 작업하고 Pull Request를 통해 검토 및 병합합니다.</li>
</ul>

<h3>흐름</h3>

<ol>
    <li><strong>브랜치 생성</strong>: 작업할 내용을 기반으로 <code>feature</code> 브랜치를 생성합니다.</li>
    <li><strong>커밋</strong>: 변경 사항을 커밋하고 푸시합니다.</li>
    <li><strong>Pull Request 생성</strong>: 작업이 완료되면 Pull Request를 생성하여 코드 리뷰를 요청합니다.</li>
    <li><strong>코드 리뷰 및 병합</strong>: 팀원들의 리뷰를 거쳐 <code>main</code> 브랜치에 병합합니다.</li>
    <li><strong>배포</strong>: <code>main</code> 브랜치에 병합되면 자동으로 배포합니다.</li>
</ol>

<hr>

<h2>🦊 GitLab Flow</h2>

<h3>개요</h3>

<p>GitLab Flow는 GitHub Flow의 단순함과 Git Flow의 환경 브랜치를 결합한 전략입니다.</p>

<h3>주요 특징</h3>

<ul>
    <li><strong>main(master)</strong> 브랜치 외에 <strong>환경 브랜치</strong>를 사용하여 배포 환경을 관리합니다.</li>
    <li>이슈 트래커와 연동하여 작업을 진행합니다.</li>
</ul>

<h3>흐름</h3>

<ol>
    <li><strong>이슈 생성</strong>: 구현할 기능이나 버그 수정을 이슈로 생성합니다.</li>
    <li><strong>브랜치 생성</strong>: 이슈 번호를 포함한 <code>feature</code> 브랜치를 생성합니다. (예: <code>feature/123-add-login</code>)</li>
    <li><strong>작업 및 커밋</strong>: 변경 사항을 커밋하고 푸시합니다.</li>
    <li><strong>Merge Request 생성</strong>: 작업이 완료되면 Merge Request를 생성하여 코드 리뷰를 요청합니다.</li>
    <li><strong>코드 리뷰 및 병합</strong>: 리뷰 후 <code>main</code> 또는 환경 브랜치에 병합합니다.</li>
    <li><strong>배포</strong>: 해당 브랜치를 배포 환경에 맞게 배포합니다.</li>
</ol>

<hr>

<h2>📝 브랜치 전략 선택 가이드</h2>

<ul>
    <li><strong>프로젝트 규모가 크고 출시 주기가 긴 경우</strong>: Git Flow를 사용하여 복잡한 릴리즈 관리에 활용합니다.</li>
    <li><strong>지속적인 배포와 빠른 출시가 필요한 경우</strong>: GitHub Flow를 사용하여 단순한 프로세스로 빠르게 작업합니다.</li>
    <li><strong>여러 배포 환경(개발, 스테이징, 프로덕션)이 있는 경우</strong>: GitLab Flow를 사용하여 환경별 브랜치를 관리합니다.</li>
</ul>

<hr>

<h2>🔧 브랜치 명명 규칙 예시</h2>

<ul>
    <li><strong>feature</strong>: <code>feature/기능명</code> (예: <code>feature/login-function</code>)</li>
    <li><strong>release</strong>: <code>release/버전</code> (예: <code>release/1.0.0</code>)</li>
    <li><strong>hotfix</strong>: <code>hotfix/버그명</code> (예: <code>hotfix/login-bug</code>)</li>
</ul>

<hr>

<h2>📂 브랜치 전략 적용 시 유의사항</h2>

<ul>
    <li><strong>일관성 유지</strong>: 팀 내에서 브랜치 전략과 명명 규칙을 명확히 정의하고 준수합니다.</li>
    <li><strong>코드 리뷰</strong>: Pull Request 또는 Merge Request를 통해 코드 리뷰 프로세스를 거칩니다.</li>
    <li><strong>커밋 메시지</strong>: 의미 있는 커밋 메시지를 작성하여 변경 사항을 명확히 합니다.</li>
    <li><strong>CI/CD 연동</strong>: 브랜치 병합 시 자동 빌드 및 배포 파이프라인을 구축합니다.</li>
</ul>

<hr>

<h2>📖 참고 자료</h2>

<ul>
    <li><a href="https://nvie.com/posts/a-successful-git-branching-model/">Git Flow 설명 by Vincent Driessen</a></li>
    <li><a href="https://guides.github.com/introduction/flow/">GitHub Flow 소개</a></li>
    <li><a href="https://docs.gitlab.com/ee/topics/gitlab_flow.html">GitLab Flow 설명</a></li>
</ul>

<hr>

<p>위의 내용을 통해 Git 브랜치 전략에 대한 이해를 높이고, 프로젝트에 적합한 브랜치 전략을 선택하여 적용하시기 바랍니다.</p>

</body>

