declare module Entities {
  export interface AccountFeature{
    created_at: any;
    description: any;
    doc_url: any;
    enabled: any;
    id: any;
    name: any;
    state: any;
    updated_at: any;
  }

  export interface Account{
    allow_tracking: any;
    beta: any;
    created_at: any;
    email: any;
    id: any;
    last_login: any;
    name?: string;
    two_factor_authentication: any;
    updated_at: any;
    verified: any;
  }

  export interface AddonService{
    created_at: any;
    id: any;
    name: any;
    updated_at: any;
  }

  export interface Addon{
    addon_service: {id: any; name: any};
    config_vars: any;
    created_at: any;
    id: any;
    name: any;
    plan: {id: any; name: any};
    provider_id: any;
    updated_at: any;
  }

  export interface AppFeature{
    created_at: any;
    description: any;
    doc_url: any;
    enabled: any;
    id: any;
    name: any;
    state: any;
    updated_at: any;
  }

  export interface AppSetup{
    id: any;
    created_at: any;
    updated_at: any;
    status: any;
    failure_message?: string;
    app: {id: any; name: any};
    build: {id: any; status: any};
    manifest_errors: any;
    postdeploy: {output: any; exit_code: any};
    resolved_success_url?: string;
  }

  export interface AppTransfer{
    app: {name: any; id: any};
    created_at: any;
    id: any;
    owner: {email: any; id: any};
    recipient: {email: any; id: any};
    state: any;
    updated_at: any;
  }

  export interface App{
    archived_at?: string;
    buildpack_provided_description?: string;
    build_stack: {id: any; name: any};
    created_at: any;
    git_url: any;
    id: any;
    maintenance: any;
    name: any;
    owner: {email: any; id: any};
    region: {id: any; name: any};
    released_at?: string;
    repo_size?: number;
    slug_size?: number;
    stack: {id: any; name: any};
    updated_at: any;
    web_url: any;
  }

  export interface BuildResult{
    build: {id: any; status: any};
    exit_code: any;
    lines: any;
  }

  export interface Build{
    created_at: any;
    id: any;
    source_blob: {url: any; version?: string};
    slug: {id: any};
    status: any;
    updated_at: any;
    user: {id: any; email: any};
  }

  export interface Collaborator{
    created_at: any;
    id: any;
    updated_at: any;
    user: {email: any; id: any};
  }

  export interface ConfigVar{
  }

  export interface Credit{
    amount: any;
    balance: any;
    created_at: any;
    expires_at: any;
    id: any;
    title: any;
    updated_at: any;
  }

  export interface Domain{
    created_at: any;
    hostname: any;
    id: any;
    updated_at: any;
  }

  export interface Dyno{
    attach_url?: string;
    command: any;
    created_at: any;
    id: any;
    name: any;
    release: {id: any; version: any};
    size: any;
    state: any;
    type: any;
    updated_at: any;
  }

  export interface Formation{
    command: any;
    created_at: any;
    id: any;
    quantity: any;
    size: any;
    type: any;
    updated_at: any;
  }

  export interface Invoice{
    charges_total: any;
    created_at: any;
    credits_total: any;
    id: any;
    number: any;
    total: any;
    updated_at: any;
  }

  export interface Key{
    comment: any;
    created_at: any;
    email: any;
    fingerprint: any;
    id: any;
    public_key: any;
    updated_at: any;
  }

  export interface LogDrain{
    addon: {id: any};
    created_at: any;
    id: any;
    token: any;
    updated_at: any;
    url: any;
  }

  export interface LogSession{
    created_at: any;
    id: any;
    logplex_url: any;
    updated_at: any;
  }

  export interface OauthAuthorization{
    access_token: {expires_in?: number; id: any; token: any};
    client: {id: any; name: any; redirect_uri: any};
    created_at: any;
    grant: {code: any; expires_in: any; id: any};
    id: any;
    refresh_token: {expires_in?: number; id: any; token: any};
    scope: any;
    updated_at: any;
  }

  export interface OauthClient{
    created_at: any;
    id: any;
    ignores_delinquent?: boolean;
    name: any;
    redirect_uri: any;
    secret: any;
    updated_at: any;
  }

  export interface OauthGrant{
  }

  export interface OauthToken{
    access_token: {expires_in?: number; id: any; token: any};
    authorization: {id: any};
    client: {secret: any};
    created_at: any;
    grant: {code: any; type: any};
    id: any;
    refresh_token: {expires_in?: number; id: any; token: any};
    session: {id: any};
    updated_at: any;
    user: {id: any};
  }

  export interface OrganizationAppCollaborator{
    created_at: any;
    id: any;
    role: any;
    updated_at: any;
    user: {email: any; id: any};
  }

  export interface OrganizationApp{
    archived_at?: string;
    buildpack_provided_description?: string;
    created_at: any;
    git_url: any;
    id: any;
    joined: any;
    locked: any;
    maintenance: any;
    name: any;
    organization: {name: any};
    owner: {email: any; id: any};
    region: {id: any; name: any};
    released_at?: string;
    repo_size?: number;
    slug_size?: number;
    stack: {id: any; name: any};
    updated_at: any;
    web_url: any;
  }

  export interface OrganizationMember{
    created_at: any;
    email: any;
    role: any;
    two_factor_authentication: any;
    updated_at: any;
  }

  export interface Organization{
    created_at: any;
    credit_card_collections: any;
    default: any;
    name: any;
    provisioned_licenses: any;
    role: any;
    updated_at: any;
  }

  export interface OtpSecret{
    created_at: any;
    id: any;
    updated_at: any;
    url: any;
  }

  export interface Plan{
    created_at: any;
    default: any;
    description: any;
    id: any;
    name: any;
    price: {cents: any; unit: any};
    state: any;
    updated_at: any;
  }

  export interface RateLimit{
    remaining: any;
  }

  export interface RecoveryCode{
  }

  export interface Region{
    created_at: any;
    description: any;
    id: any;
    name: any;
    updated_at: any;
  }

  export interface Release{
    created_at: any;
    description: any;
    id: any;
    updated_at: any;
    slug: {id: any};
    user: {id: any; email: any};
    version: any;
  }

  export interface Slug{
    blob: {method: any; url: any};
    buildpack_provided_description?: string;
    commit?: string;
    created_at: any;
    id: any;
    process_types: any;
    size?: number;
    stack: {id: any; name: any};
    updated_at: any;
  }

  export interface Source{
    source_blob: {get_url: any; put_url: any};
  }

  export interface SslEndpoint{
    certificate_chain: any;
    cname: any;
    created_at: any;
    id: any;
    name: any;
    updated_at: any;
  }

  export interface Stack{
    created_at: any;
    id: any;
    name: any;
    state: any;
    updated_at: any;
  }

}
